package models

type Config struct {
	Address       string `env:"RUN_ADDRESS"`
	DataBaseURI   string `env:"DATABASE_URI"`
	SecretKey     string `env:"SECRET_KEY"`
	ReleaseMOD    bool   `env:"RELEASE_MODE"`
	TelegramToken string `env:"TELEGRAM_TOKEN"`
	ChatId        int64  `env:"CHAT_ID"`
}
