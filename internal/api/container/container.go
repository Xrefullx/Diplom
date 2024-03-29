package container

import (
	"github.com/Xrefullx/Diplom/internal/models"
	"github.com/Xrefullx/Diplom/internal/storage"
	"github.com/Xrefullx/Diplom/internal/storage/pg"
	_ "github.com/lib/pq"
	"github.com/sarulabs/di"
	"go.uber.org/zap"
)

var DiContainer di.Container

func BuildContainer(cfg models.Config, logger *zap.Logger) error {
	builder, err := di.NewBuilder()
	if err != nil {
		return err
	}
	var LoyalityStorage storage.MaxbonusStorage
	if cfg.DataBaseURI != "" {
		LoyalityStorage, err = pg.New(cfg.DataBaseURI)
		if err != nil {
			return err
		}
	}
	if err = LoyalityStorage.Ping(); err != nil {
		return err
	}
	if err = builder.Add(di.Def{
		Name:  "server-config",
		Build: func(ctn di.Container) (interface{}, error) { return cfg, nil }}); err != nil {
		return err
	}
	if err = builder.Add(di.Def{
		Name:  "zap-logger",
		Build: func(ctn di.Container) (interface{}, error) { return logger, nil }}); err != nil {
		return err
	}
	if err = builder.Add(di.Def{
		Name:  "storage",
		Build: func(ctn di.Container) (interface{}, error) { return LoyalityStorage, nil }}); err != nil {
		return err
	}
	DiContainer = builder.Build()
	return nil
}
