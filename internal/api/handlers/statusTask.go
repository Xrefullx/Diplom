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

func StatusTask(c *gin.Context) {
	ctx, cancel := context.WithTimeout(c.Request.Context(), constant.TimeOutRequest)
	defer cancel()

	idParam := c.Param("id")
	id, err := strconv.ParseInt(idParam, 10, 64)
	if err != nil {
		c.String(http.StatusBadRequest, "Некорректный ID задачи")
		return
	}

	log := container.GetLog()
	storage := container.GetStorage()

	status, err := storage.StatusTask(ctx, id)
	if err != nil {
		log.Error(constant.ErrorWorkDataBase, zap.Error(err), zap.String("func", "GetTaskStatus"))
		c.String(http.StatusInternalServerError, constant.ErrorWorkDataBase)
		return
	}

	c.JSON(http.StatusOK, status)
}
