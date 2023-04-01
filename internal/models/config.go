package models

type Config struct {
	Address       string `env:"RUN_ADDRESS" envDefault:"localhost:8080"`
	DataBaseURI   string `env:"DATABASE_URI" envDefault:"user=postgres password=123qwe dbname=diplomMaxbonus sslmode=disable"`
	SecretKey     string `env:"SECRET_KEY" envDefault:"Xrefullx"`
	ReleaseMOD    bool   `env:"RELEASE_MODE" envDefault:"false"`
	TelegramToken string `env:"TELEGRAM_TOKEN" envDefault:6042143388:AAEbYzXYMhdsAoUQ3RsCb1T-EiyflScSxww`
}
