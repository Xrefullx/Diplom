package storage

import (
	"context"
	"github.com/Xrefullx/Diplom/internal/models"
)

type MaxbonusStorage interface {
	Ping() error
	Close() error
	Authentication(ctx context.Context, user models.User) (bool, error)
}
