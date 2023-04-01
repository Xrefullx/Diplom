package models

type AddTask struct {
	SPhone      string `json:"phone"`
	Title       string `json:"title"`
	ReasonID    int    `json:"reasonId"`
	Email       string `json:"email"`
	CompanyName string `json:"companyname"`
	StatusId    string `json:"statusId"`
	BoardId     string `json:"boardId"`
}
