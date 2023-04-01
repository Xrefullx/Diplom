package handlers

import (
	"github.com/Xrefullx/Diplom/internal/api/middleware"
	"github.com/Xrefullx/Diplom/internal/models"
	"github.com/gin-gonic/gin"
)

func Router(cfg models.Config) *gin.Engine {
	if cfg.ReleaseMOD {
		gin.SetMode(gin.DebugMode)
	}
	r := gin.New()
	r.Use(gin.Logger())
	r.Use(middleware.JwtValid())

	gUser := r.Group("/api")
	{
		gUser.POST("/login", Login)
		gUser.POST("/addTask", AddTask)
		gUser.GET("/getStatus/:id", StatusTask)
		gUser.PUT("/task/status/:id", UpdateTaskStatus)
	}
	return r
}
