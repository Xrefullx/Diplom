package models

type AddTask struct {
	ID          int    `json:"id"`
	SPhone      string `json:"phone"`
	Title       string `json:"task_title"`
	Problem     string `json:"comment"`
	ReasonID    int    `json:"reasonId"`
	Email       string `json:"email"`
	CompanyName string `json:"company_name"`
	StatusId    int `json:"statusId"`
	BoardId     int `json:"boardId"`
}
