package handlers

import (
	"context"
	"github.com/Xrefullx/Diplom/internal/api/constant"
	"github.com/Xrefullx/Diplom/internal/api/container"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"net/http"
)

func GetAllUsers(c *gin.Context) {
	ctx, cancel := context.WithTimeout(c.Request.Context(), constant.TimeOutRequest)
	defer cancel()
	log := container.GetLog()
	storage := container.GetStorage()
	statuses, err := storage.GetAllUsers(ctx)
	if err != nil {
		log.Error(constant.ErrorWorkDataBase, zap.Error(err), zap.String("func", "GetAllStatuses"))
		c.String(http.StatusInternalServerError, constant.ErrorWorkDataBase)
		return
	}
	c.JSON(http.StatusOK, gin.H{
		"statuses": statuses,
	})
}
