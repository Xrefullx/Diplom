package pg

import (
	"context"
	"database/sql"
	"errors"
	"github.com/Xrefullx/Diplom/internal/models"
	_ "github.com/lib/pq"
)

type PgStorage struct {
	connect *sql.DB
}

func New(uri string) (*PgStorage, error) {
	connect, err := sql.Open("postgres", uri)
	if err != nil {
		return nil, err
	}
	return &PgStorage{connect: connect}, nil
}

func (PS *PgStorage) Ping() error {
	if err := PS.connect.Ping(); err != nil {
		return err
	}
	err := createTables(PS.connect)
	if err != nil {
		return err
	}
	return nil
}

func (PS *PgStorage) Close() error {
	if err := PS.connect.Close(); err != nil {
		return err
	}
	return nil
}

func createTables(connect *sql.DB) error {
	_, err := connect.Exec(`
	CREATE TABLE IF NOT EXISTS public.board
	(
		id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
		"userId" integer,
		title text COLLATE pg_catalog."default",
		description text COLLATE pg_catalog."default",
		CONSTRAINT board_pkey PRIMARY KEY (id)
	);
	CREATE TABLE IF NOT EXISTS public.reason
	(
		id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
		"nameReason" text COLLATE pg_catalog."default",
		CONSTRAINT reason_pkey PRIMARY KEY (id)
	);
	CREATE TABLE IF NOT EXISTS public.status
	(
		id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
		"nameStatus" text COLLATE pg_catalog."default",
		CONSTRAINT status_pkey PRIMARY KEY (id)
	);
	CREATE TABLE IF NOT EXISTS public.task
	(
		id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
		title text COLLATE pg_catalog."default",
		"userId" integer,
		"reasonId" integer,
		"boardId" integer,
		"statusId" integer,
		icon text COLLATE pg_catalog."default",
		phone text COLLATE pg_catalog."default",
		email text COLLATE pg_catalog."default",
		"companyName" text COLLATE pg_catalog."default",
		CONSTRAINT task_pkey PRIMARY KEY (id),
		CONSTRAINT board_task FOREIGN KEY ("boardId")
			REFERENCES public.board (id) MATCH SIMPLE
			ON UPDATE NO ACTION
			ON DELETE NO ACTION
			NOT VALID,
		CONSTRAINT reason_task FOREIGN KEY ("reasonId")
			REFERENCES public.reason (id) MATCH SIMPLE
			ON UPDATE NO ACTION
			ON DELETE NO ACTION
			NOT VALID,
		CONSTRAINT status_task FOREIGN KEY ("statusId")
			REFERENCES public.status (id) MATCH SIMPLE
			ON UPDATE NO ACTION
			ON DELETE NO ACTION
			NOT VALID,
		CONSTRAINT user_task FOREIGN KEY ("userId")
			REFERENCES public."user" (id) MATCH SIMPLE
			ON UPDATE NO ACTION
			ON DELETE NO ACTION
			NOT VALID
	);
	CREATE TABLE IF NOT EXISTS public."user"
	(
		id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
		login text COLLATE pg_catalog."default",
		password text COLLATE pg_catalog."default",
		"FIO" text COLLATE pg_catalog."default",
		CONSTRAINT user_pkey PRIMARY KEY (id)
	)    
	`)
	if err != nil {
		return err
	}
	return nil
}

func (PS *PgStorage) Authentication(ctx context.Context, user models.User) (bool, error) {
	var done int
	err := PS.connect.QueryRowContext(ctx, `select count(1) from public.user where login=$1 and password=$2`,
		user.Login, user.Password).Scan(&done)
	if err != nil && !errors.Is(err, sql.ErrNoRows) {
		return false, err
	}
	if done == 0 {
		return false, nil
	}
	return true, nil
}

func (PS *PgStorage) AddTask(ctx context.Context, task models.AddTask) error {
	_, err := PS.connect.ExecContext(ctx, `INSERT INTO public.task(phone, title, reasonId ,email, companyname,statusId,boardId) VALUES ($1, $2, $3,$4,$5,$6,$7 )`,
		task.SPhone, task.Title, task.ReasonID, task.Email, task.CompanyName, task.BoardId, task.StatusId)
	return err
}

func (PS *PgStorage) StatusTask(ctx context.Context, id int64) (models.Status, error) {
	var status models.Status
	err := PS.connect.QueryRowContext(ctx, `SELECT status.id, status."nameStatus"
	FROM public."task"
	JOIN public."status" ON task.statusid = status.id
	WHERE task.id = $1;`, id).Scan(&status.Id, &status.NameStatus)
	if err != nil {
		return models.Status{}, err
	}
	return status, nil
}

func (PS *PgStorage) UpdateTaskStatus(ctx context.Context, taskId int64, statusId int64) error {
	_, err := PS.connect.ExecContext(ctx, `UPDATE tasks SET statusid = $1 WHERE id = $2;`, statusId, taskId)
	return err
}
