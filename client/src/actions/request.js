/* eslint-disable */
export const createRequest = async  ( fio, reasonID, phone, email, company_name, discription) =>  {
  fetch('https://help-maxbonus.ru/api/task/add', {
    method: 'POST',
    body: JSON.stringify({
      task_title:'Новая задача',
      id_status:1,
      fio,
      reasonID: +reasonID,
      phone,
      email,
      company_name,
      discription
    }),
    headers: {
      'Content-Type': 'application/json'
    },
  }).then((response) => response.json())
     .then((data) => {
        alert(`Ваша заявка создана, её номер ${data.id}`);
        location.reload();
     })
     .catch((err) => {
        console.log(err.message);
     });

};

export const getStatusRequest = async  (task_id, statuses) =>  {

  fetch(`https://help-maxbonus.ru/api/task/${task_id}`
  ).then((response) => response.json())
     .then((data) => {
      console.log(data);  
      if (data.task_info){

        let status = statuses.find(s => data.task_info.id_status = s.idStatus)
        alert(`Статус вашей заявки: ${status.nameStatus}`);
        location.reload();
      } else {
        alert(`Такой заявки не существует`)
      }
        return true;

     })
     .catch((err) => {
        return false;
     });
    }