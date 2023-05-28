import React from 'react';
import { useState } from 'react';
import Question from './Question';

const Questions = ({questions}) => {


  return(
<div className="questions">
            {questions.map(q => 
            <Question key={q[0]}  open={false} quest={q[0]} answer={q[1]}/>
            )}
    
          </div>
  )

}

export default Questions