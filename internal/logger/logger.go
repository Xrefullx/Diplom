package logger

import (
	"go.uber.org/zap"
	"go.uber.org/zap/zapcore"
	"gopkg.in/natefinch/lumberjack.v2"
)

func NewLogger(logFile string, maxLogSize, maxBackups, maxAge int, development bool) (*zap.Logger, error) {
	writer := &lumberjack.Logger{
		Filename:   logFile,
		MaxSize:    maxLogSize, // Максимальный размер файла лога в мегабайтах
		MaxBackups: maxBackups, // Максимальное количество сохраненных файлов
		MaxAge:     maxAge,     // Максимальное количество дней хранения файла
		LocalTime:  true,       // Использовать локальное время
		Compress:   true,       // Сжатие старых файлов лога
	}

	encoderCfg := zap.NewProductionEncoderConfig()
	encoderCfg.EncodeTime = zapcore.ISO8601TimeEncoder // Формат времени

	var encoder zapcore.Encoder
	if development {
		encoder = zapcore.NewConsoleEncoder(encoderCfg)
	} else {
		encoder = zapcore.NewJSONEncoder(encoderCfg)
	}

	core := zapcore.NewCore(
		encoder,
		zapcore.AddSync(writer),
		zap.InfoLevel,
	)

	return zap.New(core), nil
}
