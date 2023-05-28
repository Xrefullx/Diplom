import React from "react";
import Modal from "react-modal";

Modal.setAppElement("#app");

const Window = ({ show, onClose, item }) => {
    return (
        <Modal
            isOpen={show}
            onRequestClose={onClose}
            className={"modal"}
            overlayClassName={"overlay"}
        >
            <div className={"close-btn-ctn"}>
                <h1 style={{ flex: "1 90%" }}>{item.title}</h1>
                <button className="close-btn" onClick={onClose}>X</button>
            </div>
            <div>
                <p className = {"item-title"}>{item.task_title}</p>
                <p className = {"item-reason"}>{item.name_reason}</p>
                <p className = {"item-problem"}>{item.problem}</p>
                <p className = {"item-problem"}>{item.problem}</p>
                <p className = {"item-fio"}>{item.fio}</p>
                <p className = {"item-phone"}>{item.phone}</p>
                <p className = {"item-email"}>{item.email}</p>
                <p className = {"item-reason"}>{item.name_reason}</p>
                <p className = {"item-company"}>{item.company}</p>
            </div>
        </Modal>
    );
};

export default Window;