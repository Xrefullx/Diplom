import React from 'react';
import { useState, useEffect } from 'react';
import { getStatusRequest } from '../../actions/request';
import axios from 'axios';

const checkStatusModal = ({open, onClose}) => {

  const onSubmit = async (e) => {
    e.preventDefault();
    getStatusRequest(e.target.task_id.value, statuses);

  };

  const [statuses, setStatus] = useState([]);
  useEffect(()=>{

    axios
    .get("https://help-maxbonus.ru/api/status")
    .then(data =>{
       setStatus(data?.data?.statuses);
    });
    ;
  })



if (!open) return null;
document.body.style.overflow='hidden';
  return (
    <div className='overlay' onClick={onClose}>
      <div className="checkStatusModal">
        <div className="headerRequestModal">
        <h3 className="requestHeader">Проверка статуса заявки</h3>
        <div className="closeRequest" onClick={onClose}></div>
        </div>
        <div className="requestInputs">
          <form onSubmit={(e) => onSubmit(e)}>
          <input className='requestInput' name="task_id" placeholder='Номер Заявки'></input>
          <button className='btn btn_inner requestBtn pointer' type="submit">Проверить статус</button>
          </form>
        </div>
      </div>
      </div>
  )
}

export default checkStatusModal