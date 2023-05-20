package pg

import (
	"context"
	"database/sql"
	"errors"
	"fmt"
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
	    "problem" text,
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
	_, err := PS.connect.ExecContext(ctx, `INSERT INTO public.task(phone, title, reasonId ,email, companyname,statusId,boardId,problem) VALUES ($1, $2, $3,$4,$5,$6,$7,$8 )`,
		task.SPhone, task.Title, task.ReasonID, task.Email, task.CompanyName, task.BoardId, task.StatusId, task.Problem)
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
	_, err := PS.connect.ExecContext(ctx, `UPDATE task SET statusid = $1 WHERE id = $2;`, statusId, taskId)
	return err
}

func (PS *PgStorage) UpdateDescription(ctx context.Context, taskId int64, description string) error {
	_, err := PS.connect.ExecContext(ctx, `UPDATE task SET description = $1 WHERE id = $2;`, description, taskId)
	return err
}

func (PS *PgStorage) GetAllStatuses(ctx context.Context) ([]models.Status, error) {
	rows, err := PS.connect.QueryContext(ctx, `SELECT id, "nameStatus" FROM public.status;`)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var statuses []models.Status
	for rows.Next() {
		var status models.Status
		err := rows.Scan(&status.Id, &status.NameStatus)
		if err != nil {
			return nil, err
		}
		statuses = append(statuses, status)
	}
	return statuses, nil
}

func (PS *PgStorage) GetAllReason(ctx context.Context) ([]models.Reason, error) {
	rows, err := PS.connect.QueryContext(ctx, `SELECT id, "nameReason" FROM public.reason;`)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var statuses []models.Reason
	for rows.Next() {
		var status models.Reason
		err := rows.Scan(&status.Id, &status.NameReason)
		if err != nil {
			return nil, err
		}
		statuses = append(statuses, status)
	}
	return statuses, nil
}

func (PS *PgStorage) GetAllUsers(ctx context.Context) ([]models.Users, error) {
	rows, err := PS.connect.QueryContext(ctx, `SELECT id, "FIO" FROM public."user";`)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var userses []models.Users
	for rows.Next() {
		var users models.Users
		err := rows.Scan(&users.Id, &users.FIO)
		if err != nil {
			return nil, err
		}
		userses = append(userses, users)
	}
	return userses, nil
}

func (PS *PgStorage) DeleteTask(ctx context.Context, taskId int64) error {
	_, err := PS.connect.ExecContext(ctx, `DELETE FROM task WHERE id = $1;`, taskId)
	return err
}

func (PS *PgStorage) UpdateTask(ctx context.Context, taskId string, task models.Task) error {
	query := `UPDATE task SET title = $1, userId = $2, reasonid = $3, boardid = $4, statusid = $5, icon = $6, phone = $7, email = $8, companyname = $9 WHERE id = $10`
	result, err := PS.connect.ExecContext(ctx, query, task.Title, task.UserId, task.ReasonId, task.BoardId, task.StatusID, task.Icon, task.Phone, task.Email, task.CompanyName, taskId)
	if err != nil {
		return err
	}
	rowsAffected, err := result.RowsAffected()
	if err != nil {
		return err
	}

	if rowsAffected == 0 {
		return fmt.Errorf("no rows affected, task not found")
	}

	return nil
}

func (PS *PgStorage) GetTaskInfo(ctx context.Context) ([]models.TaskInfo, error) {
	query := `
		SELECT public.task.id, COALESCE(public.task.title, ''), COALESCE("FIO", ''), COALESCE("nameReason", ''), COALESCE(public.board.title, ''), 
		       public.status.id, COALESCE(icon, ''), COALESCE(phone, ''), COALESCE(email, ''), COALESCE(companyname, ''), COALESCE(problem, ''),COALESCE(public.task.description, '')
		FROM public.task
		left JOIN public."user" ON public."user".id = public.task.userId
		left JOIN public."reason" ON public."reason".id = public.task.reasonid
		left JOIN public.board ON public.board.id = public.task.boardid
		left JOIN public.status ON public.status.id = public.task.statusid
	`
	rows, err := PS.connect.QueryContext(ctx, query)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var tasks []models.TaskInfo
	for rows.Next() {
		var task models.TaskInfo
		err := rows.Scan(&task.ID, &task.TaskTitle, &task.FIO, &task.NameReason, &task.BoardTitle, &task.NameStatus,
			&task.Icon, &task.Phone, &task.Email, &task.CompanyName, &task.Problem, &task.Description)
		if err != nil {
			return nil, err
		}
		tasks = append(tasks, task)
	}
	return tasks, nil
}

func (PS *PgStorage) GetTaskInfoId(ctx context.Context, taskID int64) ([]models.TaskInfo, error) {
	query := `
		SELECT public.task.id, COALESCE(public.task.title, ''), COALESCE("FIO", ''), COALESCE("nameReason", ''), COALESCE(public.board.title, ''), public.status.id, COALESCE(icon, ''), 
		       COALESCE(phone, ''), COALESCE(email, ''), COALESCE(companyname, ''), COALESCE(problem, ''),COALESCE(public.task.description, '')
		FROM public.task
		JOIN public."user" ON public."user".id = public.task.userId
		JOIN public."reason" ON public."reason".id = public.task.reasonid
		JOIN public.board ON public.board.id = public.task.boardid
		JOIN public.status ON public.status.id = public.task.statusid
		WHERE public.task.id = $1
	`
	rows, err := PS.connect.QueryContext(ctx, query, taskID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var tasks []models.TaskInfo
	for rows.Next() {
		var task models.TaskInfo
		err := rows.Scan(&task.ID, &task.TaskTitle, &task.FIO, &task.NameReason, &task.NameStatus, &task.Icon, &task.Phone, &task.Email, &task.CompanyName, &task.Problem, &task.Description)
		if err != nil {
			return nil, err
		}
		tasks = append(tasks, task)
	}
	return tasks, nil
}
