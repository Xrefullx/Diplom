package handlers

import (
	"context"
	"github.com/Xrefullx/Diplom/internal/api/constant"
	"github.com/Xrefullx/Diplom/internal/api/container"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"net/http"
	"strconv"
)

func DeleteTask(c *gin.Context) {
	ctx, cancel := context.WithTimeout(c.Request.Context(), constant.TimeOutRequest)
	defer cancel()
	taskIdParam := c.Param("id")
	taskId, err := strconv.ParseInt(taskIdParam, 10, 64)
	if err != nil {
		c.String(http.StatusBadRequest, "Некорректный ID задачи")
		return
	}
	log := container.GetLog()
	storage := container.GetStorage()
	err = storage.DeleteTask(ctx, taskId)
	if err != nil {
		log.Error(constant.ErrorWorkDataBase, zap.Error(err), zap.String("func", "DeleteTask"))
		c.String(http.StatusInternalServerError, constant.ErrorWorkDataBase)
		return
	}
	c.JSON(http.StatusOK, gin.H{
		"message": "Задача успешно удалена",
	})
}
