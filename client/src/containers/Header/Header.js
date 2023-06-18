import {useState} from "react";
import {useDispatch} from 'react-redux';

import style from './Header.module.css';

import {openModal} from '../../redux/slices/modalSlice';

import {NEW_REQUEST_MODAL_ID} from '../../modals/NewRequestModal/NewRequestModal'
import {CHECK_STATUS_MODAL_ID} from '../../modals/CheckStatusModal/CheckStatusModal'

export function Header() {
    const [isCollapse, setIsCollapse] = useState(true);
    const dispatch = useDispatch();

    return (
        <header
            className={[
                style.header,
                (isCollapse ? style.collapsed : style.uncollapsed)
            ].join(' ')}

            onClick={(event) => {
                if (!event.target.className.includes(style.header))
                    return;

                if (isCollapse === true)
                    return;

                setIsCollapse(!isCollapse)
            }}
        >

            <div
                className={style.headerContainer}
            >
                <a
                    href='/'
                    className={style.logo}
                >
                    <img
                        src="https://static.tildacdn.com/tild3334-6463-4634-b736-626564356364/1.png"
                        alt='logo'
                    />
                </a>
                <nav>
                    <a
                        href="#faq"
                        onClick={() => {
                            setIsCollapse(true);
                        }}
                    >
                        Часто задаваемые вопросы
                    </a>
                    <a
                        href="#contacts"
                        onClick={() => setIsCollapse(true)}
                    >
                        Контакты
                    </a>
                    <button
                        onClick={() => {
                            dispatch(openModal(CHECK_STATUS_MODAL_ID))
                            setIsCollapse(true);
                        }}
                    >
                        Проверить статус заявки
                    </button>
                    <button
                        className={style.checkStatusModal}
                        onClick={() => {
                            dispatch(openModal(NEW_REQUEST_MODAL_ID));
                            setIsCollapse(true);
                        }}
                    >
                        Связаться
                    </button>
                </nav>
                <button
                    className={style.serviceButton}
                    onClick={() => {
                        setIsCollapse(!isCollapse)
                    }}
                >
                    <div/>
                    <div/>
                    <div/>
                </button>

            </div>
        </header>)
}