package models

type TaskInfo struct {
	ID          int    `json:"id"`
	TaskTitle   string `json:"task_title"`
	FIO         string `json:"fio"`
	NameReason  string `json:"name_reason"`
	BoardTitle  string `json:"board_title"`
	NameStatus  int64  `json:"id_status"`
	Icon        string `json:"icon"`
	Phone       string `json:"phone"`
	Email       string `json:"email"`
	CompanyName string `json:"company_name"`
	Problem     string `json:"comment"`
	Description string `json:"description"`
}
