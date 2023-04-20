package main

import (
	"flag"
	"fmt"
	"github.com/Xrefullx/Diplom/internal/api/constant"
	"github.com/Xrefullx/Diplom/internal/api/container"
	"github.com/Xrefullx/Diplom/internal/api/handlers"
	"github.com/Xrefullx/Diplom/internal/api/server"
	"github.com/Xrefullx/Diplom/internal/logger"
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
		zap.Bool("ReleaseMOD", cfg.ReleaseMOD),
	)
	zapLogger.Debug("full configuration", zap.Any("config", cfg))
	if err = container.BuildContainer(cfg, zapLogger); err != nil {
		zapLogger.Fatal("error starting the Di container", zap.Error(err))
	}
	logger, err := logger.NewLogger("logs/app.log", 100, 30, 30, true) // Путь к файлу, размер файла (МБ), кол-во сохраненных файлов, срок хранения (дни), режим разработки
	if err != nil {
		panic(fmt.Sprintf("cannot create logger: %v", err))
	}
	defer logger.Sync()
	zap.ReplaceGlobals(logger)
	defer func() {
		if err = container.GetStorage().Close(); err != nil {
			zapLogger.Fatal(constant.ErrorWorkDataBase, zap.Error(err))
		}
	}()
	r := handlers.Router(cfg)
	server.InitServer(r, cfg)
}
