package handlers

import (
	"context"
	"encoding/json"
	"fmt"
	"github.com/Xrefullx/Diplom/internal/api/constant"
	"github.com/Xrefullx/Diplom/internal/api/container"
	"github.com/Xrefullx/Diplom/internal/api/utils"
	"github.com/Xrefullx/Diplom/internal/models"
	"github.com/gin-gonic/gin"
	tgbotapi "github.com/go-telegram-bot-api/telegram-bot-api"
	"go.uber.org/zap"
	"net/http"
)

func UpdateTask(c *gin.Context) {
	ctx, cancel := context.WithTimeout(c.Request.Context(), constant.TimeOutRequest)
	defer cancel()
	if !utils.ValidContent(c, "application/json") {
		return
	}
	log := container.GetLog()
	storage := container.GetStorage()
	var task models.Task
	err := json.NewDecoder(c.Request.Body).Decode(&task)
	if err != nil {
		log.Error(constant.ErrorUnmarshalBody, zap.Error(err))
		c.String(http.StatusInternalServerError, constant.ErrorUnmarshalBody)
		return
	}
	taskID := c.Param("id")
	if taskID == "" {
		log.Error("Task ID is missing")
		c.String(http.StatusBadRequest, "Task ID is missing")
		return
	}
	log.Debug("Updating task", zap.Any("task", task))
	err = storage.UpdateTask(ctx, taskID, task)
	if err != nil {
		log.Error(constant.ErrorWorkDataBase, zap.Error(err), zap.String("func", "UpdateTask"))
		c.String(http.StatusInternalServerError, constant.ErrorWorkDataBase)
		return
	}
	log.Debug("Task updated successfully", zap.String("taskID", taskID))
	c.String(http.StatusOK, fmt.Sprintf("Task %s updated successfully", taskID))
	telegramToken := "6042143388:AAEbYzXYMhdsAoUQ3RsCb1T-EiyflScSxww"
	telegramChatID := int64(-855483332)
	notificationMessage := fmt.Sprintf("Заявка от компании %s. изменила статус ", task.CompanyName)

	if err := TelegramNotification(telegramToken, telegramChatID, notificationMessage); err != nil {
		log.Error("Ошибка отправки уведомления в Telegram", zap.Error(err))
	}
}

func TelegramNotification(token string, chatID int64, message string) error {
	bot, err := tgbotapi.NewBotAPI(token)
	if err != nil {
		return err
	}

	msg := tgbotapi.NewMessage(chatID, message)
	_, err = bot.Send(msg)
	return err
}
