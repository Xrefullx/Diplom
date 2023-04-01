package models

type Task struct {
	Title       string `json:"title"`
	UserId      int64  `json:"userId"`
	ReasonId    int64  `json:"resonId"`
	BoardId     int64  `json:"boardId"`
	StatusID    int64  `json:"statusID"`
	Icon        string `json:"icon"`
	Phone       string `json:"phone"`
	Email       string `json:"email"`
	CompanyName string `json:"companyName"`
}
