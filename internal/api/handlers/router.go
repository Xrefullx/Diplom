package handlers

import (
	"github.com/Xrefullx/Diplom/internal/api/middleware"
	"github.com/Xrefullx/Diplom/internal/models"
	"github.com/gin-gonic/gin"
)

func Router(cfg models.Config) *gin.Engine {
	if cfg.ReleaseMOD {
		gin.SetMode(gin.ReleaseMode)
	}
	r := gin.New()
	r.Use(gin.Logger())
	r.Use(middleware.JwtValid())

	gUser := r.Group("/api")
	{
		gUser.POST("/login", Login)
		gUser.POST("/task/add", AddTask)
		gUser.GET("/task/status/:id", StatusTask)
		gUser.PUT("/task/status/:id", UpdateTaskStatus)
		gUser.GET("/status", GetAllStatuses)
		gUser.GET("/users", GetAllUsers)
		gUser.DELETE("/task/:id", DeleteTask)
		gUser.PUT("/task/:id", UpdateTask)
		gUser.GET("task/info", GetTaskInfo)
		gUser.GET("task/info/:id", GetTaskInfoId)
	}
	return r
}
