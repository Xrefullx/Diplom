package models

type Board struct {
	Id          int64  `json:"Id"`
	UserId      int64  `json:"userId"`
	Title       string `json:"title"`
	Description string `json:"description"`
}
