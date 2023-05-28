import React, { Fragment, useState, useRef} from "react";
import {useDrag, useDrop} from "react-dnd";
import WIndow from "./Window";
import TASK_TYPE from "../data/types";

const Item = ({item, index, moveItem, status}) => {
  const ref = useRef(null);

    const [, drop] = useDrop({
      accept: TASK_TYPE,
      hover(item, monitor) {
        if (!ref.current){
          return;
        }

        const dragIndex = item.index;
        const hoverIndex = index;

        if (dragIndex === hoverIndex){
          return
        }

        const hoveredRect = ref.current.getBoundClientRect();
        const hoverMiddleY = (hoveredRect.bottom - hoveredRect.top) / 2;
        const mousePosition = monitor.getClientOffset();
        const hoverClientY = mousePosition.y - hoveredRect.top;

        if (dragIndex < hoverIndex && hoverClientY < hoverMiddleY){
          return;
        }

        if (dragIndex > hoverIndex && hoverClientY < hoverMiddleY) {
          return;
        }

        moveItem(dragIndex, hoverIndex);
        item.index = hoverIndex;

      }
    });

    const [{ isDragging }, drag] = useDrag({
      item: { type: TASK_TYPE, ...item, index },
      collect: monitor => ({
          isDragging: monitor.isDragging()
      })
  });

    const [show, setShow] = useState(false);
    const onOpen = () => setShow(true);
    
    const onClose = () => setShow(false);

    drag(drop(ref));

  return (
    <Fragment>
      <div
          ref={ref}
          style={{ opacity: isDragging ? 0 : 1 }}
          className={"item"}
          onClick={onOpen}
>
        
        <p className = {"item-title"}>{item.task_title}</p>
        <p className = {"item-reason"}>{item.name_reason}</p>
        <p className = {"item-fio"}>{item.fio}</p>
        <p className = {"item-phone"}>{item.phone}</p>
        <p className = {"item-email"}>{item.email}</p>
        <p className = {"item-reason"}>{item.name_reason}</p>
        <p className = {"item-company"}>{item.company_name}</p>
        <p className = {"item-problem"}>{item.comment}</p>
      </div>

    </Fragment>
  )
}

export default Item;