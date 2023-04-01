package main

import (
	"flag"
	"github.com/Xrefullx/Diplom/internal/api/constant"
	"github.com/Xrefullx/Diplom/internal/api/container"
	"github.com/Xrefullx/Diplom/internal/api/handlers"
	"github.com/Xrefullx/Diplom/internal/api/server"
	"github.com/Xrefullx/Diplom/internal/models"
	"github.com/caarlos0/env/v6"
	"go.uber.org/zap"
	"log"
)

var cfg models.Config

func init() {
	flag.StringVar(&cfg.Address, "a", cfg.Address, "the launch address of the HTTP server")
	flag.StringVar(&cfg.DataBaseURI, "d", cfg.DataBaseURI, "a string with the address of the database connection")
}
func main() {
	var zapLogger *zap.Logger
	var err error
	if err = env.Parse(&cfg); err != nil {
		log.Fatalln("config reading error", zap.Error(err))
	}
	flag.Parse()
	if cfg.ReleaseMOD {
		zapLogger, err = zap.NewProduction()
	} else {
		zapLogger, err = zap.NewDevelopment()
	}
	if err != nil {
		log.Fatalln(err)
	}
	zapLogger.Info("the following configuration is read",
		zap.String("AddressServer", cfg.Address),
		zap.String("AccrualAddress", cfg.AccrualAddress),
		zap.Bool("ReleaseMOD", cfg.ReleaseMOD),
	)
	zapLogger.Debug("full configuration", zap.Any("config", cfg))
	if err = container.BuildContainer(cfg, zapLogger); err != nil {
		zapLogger.Fatal("error starting the Di container", zap.Error(err))
	}
	defer func() {
		if err = container.GetStorage().Close(); err != nil {
			zapLogger.Fatal(constant.ErrorWorkDataBase, zap.Error(err))
		}
	}()
	r := handlers.Router(cfg)
	server.InitServer(r, cfg)
}
