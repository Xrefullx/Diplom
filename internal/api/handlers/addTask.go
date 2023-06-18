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
	"os"
	"strconv"
)

func AddTask(c *gin.Context) {
	ctx, cancel := context.WithTimeout(c.Request.Context(), constant.TimeOutRequest)
	defer cancel()
	if !utils.ValidContent(c, "application/json") {
		return
	}
	log := container.GetLog()
	storage := container.GetStorage()
	var task models.AddTask
	err := json.NewDecoder(c.Request.Body).Decode(&task)
	if err != nil {
		log.Error(constant.ErrorUnmarshalBody, zap.Error(err))
		c.String(http.StatusInternalServerError, constant.ErrorUnmarshalBody)
		return
	}
	log.Debug("Добавление новой задачи", zap.Any("task", task))
	task.StatusId = 1
	task.BoardId = 1
	id, err := storage.AddTask(ctx, task)
	if err != nil {
		log.Error(constant.ErrorWorkDataBase, zap.Error(err), zap.String("func", "AddTask"))
		c.String(http.StatusInternalServerError, constant.ErrorWorkDataBase)
		return
	}
	log.Debug("Новая задача добавлена успешно", zap.Any("task", task), zap.Int64("id", id))
	c.JSON(http.StatusCreated, gin.H{"id": id})
	telegramToken := os.Getenv("TELEGRAM_TOKEN")
	telegramChatIDStr := os.Getenv("CHAT_ID")
	telegramChatID, err := strconv.ParseInt(telegramChatIDStr, 10, 64)
	if err != nil {
		fmt.Println("Error converting string to int64:", err)
		return
	}
	notificationMessage := fmt.Sprintf("Поступила новая заявка, от компании:  %s\n"+
		"Номер телефона: %s\n"+"Email: %s\n"+"Описание проблемы: %s\n", task.CompanyName, task.SPhone, task.Email, task.Discription)
	if err := sendTelegramNotification(telegramToken, telegramChatID, notificationMessage); err != nil {
		log.Error("Ошибка отправки уведомления в Telegram", zap.Error(err))
	}
}

func sendTelegramNotification(token string, chatID int64, message string) error {
	bot, err := tgbotapi.NewBotAPI(token)
	if err != nil {
		return err
	}
	msg := tgbotapi.NewMessage(chatID, message)
	_, err = bot.Send(msg)
	return err
}
