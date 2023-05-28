import React, { useState, useEffect } from "react";
import { useDrop } from "react-dnd";
import TASK_TYPE from "../data/types";
import axios from 'axios';



const DropWrapper = ({ onDrop, children, status }) => {

    const [statuses, setStatus] = useState([]);
    useEffect(()=>{
      let isActive = true;
      axios
      .get("https://help-maxbonus.ru/api/status")
      .then(data =>{
        if (isActive) setStatus(data?.data?.statuses);
      });
      return () => { isActive = false };
    })

    const [{ isOver }, drop] = useDrop({
        accept: TASK_TYPE,
        canDrop: (item, monitor) => {
            const itemIndex = statuses.findIndex(si => item.id_status === si.idStatus);
            const statusIndex = statuses.findIndex(si => si.idStatus === status.idStatus);
            return [itemIndex + 1, itemIndex - 1, itemIndex].includes(statusIndex);
        },
        drop: (item, monitor) => {
            onDrop(item, monitor, status);
        },
        collect: monitor => ({
            isOver: monitor.isOver()
        })
    });

    return (
        <div ref={drop} className={"drop-wrapper"}>
            {React.cloneElement(children, { isOver })}
        </div>
    )
};

export default DropWrapper;