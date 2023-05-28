import React from 'react';
import { useState } from 'react';
import { createRequest } from '../../actions/request';
import axios from 'axios';

const NewRequestModal = ({open, onClose}) => {

  const [reasons, setReasons] = useState([]);
  const onSubmit = async (e) => {
    e.preventDefault();
    console.log(e);
    const fieldInfo = e.target;
    createRequest(fieldInfo.fio.value,fieldInfo.reasonID.value,fieldInfo.phone.value,fieldInfo.email.value,fieldInfo.company.value,fieldInfo.comment.value);

  };

  
  const fetchReasonsData = () => {
    fetch("https://help-maxbonus.ru/api/reason")
      .then(response => {
        
        return response.json();
       
      })
      .then(data => {
        setReasons(data.reason);
      })
  }
 (reasons.length === 0) ? fetchReasonsData() : 0;

if (!open) return null;
document.body.style.overflow='hidden';
  return (
    <div className='overlay' onClick={onClose} >
      <div className="newRequestModal">
        <div className="headerRequestModal">
        <h3 className="requestHeader">Оформить заявку</h3>
        <div className="closeRequest" onClick={onClose}></div>
        </div> 
        <form onSubmit={(e) => onSubmit(e)}>
        <div className="requestInputs">
          <input className='requestInput' key="fio" name="fio" placeholder='ФИО' required></input>
          <input className='requestInput' name="phone" placeholder='+7 (999) 999-99-99' required></input>
          <input className='requestInput' name="email" placeholder='Электронная почта' required></input>
          <input className='requestInput' name="company" placeholder='Название компании' required></input>
          <select name="reasonID" className='requestInput' placeholder='Причина обращения' required>
            <option selected="true" disabled="disabled">Причина обращения:</option>
            {reasons.map(r =>  <option key={'reason'+r.id} value={r.id}>{r.nameReason}</option>)}
            
          </select>
          <textarea className='requestInput requestInput_description' name="comment" placeholder='Описание проблемы'></textarea>
          <button className='btn btn_inner requestBtn pointer' type="submit">Оставить заявку</button>
          
        </div>
        </form>
      </div>
      </div>
  )
}

export default NewRequestModal