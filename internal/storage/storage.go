package storage

import (
	"context"
	"github.com/Xrefullx/Diplom/internal/models"
)

type MaxbonusStorage interface {
	Ping() error
	Close() error
	Authentication(ctx context.Context, user models.User) (bool, error)
	AddTask(ctx context.Context, user models.AddTask) error
	StatusTask(ctx context.Context, id int64) (models.Status, error)
	UpdateTaskStatus(ctx context.Context, taskId int64, statusId int64) error
	GetAllStatuses(ctx context.Context) ([]models.Status, error)
	GetAllUsers(ctx context.Context) ([]models.Users, error)
	DeleteTask(ctx context.Context, taskId int64) error
}
