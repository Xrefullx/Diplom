import React, { useEffect, useState } from 'react';
import { Button } from '@material-ui/core';
import { Redirect } from 'react-router-dom';
import { useSelector } from 'react-redux';
import NewRequestModal from '../landing/NewRequestModal';
import CheckStatusModal from '../landing/CheckStatusModal';
import Questions from '../landing/Questions';

const Landing = () => {
  const isAuthenticated = useSelector((state) => state.auth.isAuthenticated);

  const [openNewRequestModal, setOpenRequestModal] = useState(false);
  const [openCheckStatusModal, setCheckStatusModal] = useState(false);
  useEffect(() => {
    document.title = 'MaxBonus';
  }, []);

  const [question1,setQuestion1] = useState(false);

  return (
    <div>
    <section className='landing'>
      <nav className='header'>
        <img src="logo.png" alt="logo" /><h1>MaxBonus</h1>
        <nav className=''>
        <ul className="header__navigation">
            <li><a href="#freq_questions">Часто задаваемые вопросы</a></li>
            <li><a href="#contacts">Контакты</a></li>
            <li className='text_orange'><a href='#' className='pointer' onClick={() => setCheckStatusModal(true)}>Проверить статус заявки</a></li>
            <li><a href="#contacts" className="btn">Связаться</a></li>
          </ul>
 
        </nav>
      </nav>
      <div className='landing__section1 section '>
        <div className="section1__left">
          <h2 className= "section1__header headline">Платформа лояльности и управления потребительским опытом</h2>
          <button onClick={() => setOpenRequestModal(true)} className="btn btn_inner section1__btn pointer">Оставить заявку</button>
        </div>
        
        <div className="section1__right">
        <img src="phone_example.png" alt="phone example" />
      </div>
      </div>

      <div className='landing__section2 section '>
          <h2 className= "section2__header headline" id="freq_questions">Часто задаваемые вопросы</h2>
          <Questions questions={[['Как обрабатывается заявка?','После того, как Вы подали заявку наш менеджер берёт её в работу, направляет её на следующий отдел.'],
          ['Срок обработки заявки?','На решение заявки у нас уходит от 1 до 3 дней, но в некоторых случаях нам может потребоваться чуть больше времени.'],
          ['Не работает лояльность','Если у Вас не работает лояльность, то необходимо написать/позвонить нашему менеджеру для быстрого решения.']]}/>
      </div>

      <div className='landing__section3 section' id="contacts">
          <h2 className= "section3__header headline email">Maxbonus.info@gmail.com</h2>
          <div className="employee">
          <img src="./assets/igor.png" alt="avatar" className="employee__avatar" />
            <div className="employee__info">
            
              <div className="employee__important">Анна</div>
              <div className="employee__status">Старший менеджер</div>
            </div>
            <div className="employee__important">+7 (999) 999-99-99</div>
            <div className="employee__important"><a href="https://t.me/PyotrGorbunov" target="_blank" rel="noopener noreferrer">telegram</a></div>
          </div>
      </div>
      
    </section>
    <footer className='footer'>
      <div className="footer__info">
      <img src="logo.png" alt="logo" />
      <div className="footer__copyright">
      © Все права защищены
      </div>
      </div>
    </footer>
    <NewRequestModal open={openNewRequestModal} onClose={(e)=>  {if (e.target.className === 'overlay' || e.target.className =='closeRequest'){setOpenRequestModal(false); document.body.style.overflow='visible';}}}/>
    <CheckStatusModal open={openCheckStatusModal} onClose={(e)=> {if (e.target.className === 'overlay' || e.target.className =='closeRequest'){setCheckStatusModal(false); document.body.style.overflow='visible';}}}/>
    </div>
    
  );
};

export default Landing;
