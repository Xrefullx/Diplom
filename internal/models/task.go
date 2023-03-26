package models

type Task struct {
	Id          int64  `json:"id"`
	Title       string `json:"title"`
	UserId      int64  `json:"userId"`
	ReasonId    int64  `json:"resonId"`
	BoardId     string `json:"boardId"`
	StatusID    int64  `json:"statusID"`
	Icon        string `json:"icon"`
	Phone       string `json:"phone"`
	Email       string `json:"email"`
	CompanyName string `json:"companyName"`
}
