import {getTasks,getStatuses } from '../../actions/board';
import React, { useState, useEffect } from "react";
import Item from "../board/Item";
import DropWrapper from "../board/DropWrapper";
import Col from "../board/Col";
import axios from 'axios';
import { DndProvider } from "react-dnd";
import {HTML5Backend} from "react-dnd-html5-backend";


const Board = () => {


  console.log(document.classList);


  const [statuses, setStatus] = useState([]);
  useEffect(()=>{

    axios
    .get("https://help-maxbonus.ru/api/status")
    .then(data =>{
       setStatus(data?.data?.statuses);
    });
    ;
  })
  
  const [items, setItems] = useState([]);

  const fetchItemsData = () => {
    fetch("https://help-maxbonus.ru/api/task")
      .then(response => {
        return response.json()
      })
      .then(data => {
        setItems(data?.task_info)
      })
  }

  useEffect(() => {
    fetchItemsData();
  }, [])


  const onDrop = (item, monitor, status) => {
    const mapping = statuses.find(si => si.idStatus === status.idStatus);

    setItems(prevState => {
        const newItems = prevState
            .filter(i => i.id !== item.id)
            .concat({ ...item, status});
        return [ ...newItems ];
    });
};

const moveItem = (dragIndex, hoverIndex) => {
    const item = items[dragIndex];
    setItems(prevState => {
        const newItems = prevState.filter((i, idx) => idx !== dragIndex);
        newItems.splice(hoverIndex, 0, item);
        return  [ ...newItems ];
    });
};



    return (  
      
      <DndProvider backend={HTML5Backend} >
        <div className={"row"}>
        {statuses.map(s => {
                return (
                    
                    <div key={`status${s.idStatus}`} className={"col-wrapper"}>
                        <h2 className={"col-header"}>{s.nameStatus.toUpperCase()}</h2>
                        <DropWrapper onDrop={onDrop} status={s.nameStatus}>
                            <Col>
                            {items
                                    .filter(i => i.id_status === s.idStatus)
                                    .map((i, idx) => <Item key={i.id} item={i} index={idx} moveItem={moveItem} status={s} />)
                                }
                            </Col>
                        </DropWrapper>
                    </div>
                );
            })}
        </div>
        </DndProvider>
    );
};

export default Board;