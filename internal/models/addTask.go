package models

type AddTask struct {
	ID          int    `json:"id"`
	SPhone      string `json:"phone"`
	Title       string `json:"title"`
	Problem     string `json:"problem"`
	ReasonID    int    `json:"reasonId"`
	Email       string `json:"email"`
	CompanyName string `json:"companyname"`
	StatusId    string `json:"statusId"`
	BoardId     string `json:"boardId"`
}
