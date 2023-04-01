package constant

import "errors"

const (
	ErrorWorkDataBase  = "ошибка работы с базой данных"
	ErrorUnmarshalBody = "ошибка Unmarshal тело запроса"
	ErrorReadBody      = "ошибка чтения тело запроса"
)

var ErrorNoUNIQUE = errors.New("ошибка значение не уникально")
