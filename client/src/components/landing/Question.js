import React, {useState} from 'react';
const Question = ({open, quest, answer , onClose}) => {

  let [status,setStatus] = useState(open);

function changeStatus(){
  setStatus(!status);
}

  return(
    <div className='quest' onClick={changeStatus}>
    <div className="questQuestion">
              <div className="quest__text">{quest}</div>
              <div className={"quest__icon " + ((status) ? 'quest__icon_active' : '')}></div>
            </div>
            <div className={ 'questAnswer ' + ((status) ? ''  : 'questAnswerClosed')}>{answer}</div>
             
            
</div>
  )

}

export default Question