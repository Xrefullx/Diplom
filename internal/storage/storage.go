package storage

import (
	"context"
	"github.com/Xrefullx/Diplom/internal/models"
)

type MaxbonusStorage interface {
	Ping() error
	Close() error
	Authentication(ctx context.Context, user models.User) (bool, error)
	AddTask(ctx context.Context, user models.AddTask) (int64,error)
	StatusTask(ctx context.Context, id int64) (models.Status, error)
	UpdateTaskStatus(ctx context.Context, taskId int64, statusId int64) error
	UpdateDescription(ctx context.Context, taskId int64, description string) error
	GetAllStatuses(ctx context.Context) ([]models.Status, error)
	GetAllUsers(ctx context.Context) ([]models.Users, error)
	GetAllReason(ctx context.Context) ([]models.Reason, error)
	GetTaskInfo(ctx context.Context) ([]models.TaskInfo, error)
	GetTaskInfoId(ctx context.Context, taskID int64) ([]models.TaskInfo, error)
	DeleteTask(ctx context.Context, taskId int64) error
	UpdateTask(ctx context.Context, taskId string, task models.Task) error
}
