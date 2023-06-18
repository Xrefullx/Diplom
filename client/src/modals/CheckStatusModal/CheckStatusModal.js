import {useDispatch, useSelector} from "react-redux";

import CircularProgress from "@mui/material/CircularProgress";
import {GrClose} from "react-icons/gr";

import styles from './CheckStatusModal.module.css';

import {CheckStatusForm} from '../../containers/CheckStatusForm/CheckStatusForm';

import {closeModal} from "../../redux/slices/modalSlice";
import {clearFetchStatus} from "../../redux/slices/requestSlice";

export const CHECK_STATUS_MODAL_ID = 'CheckStatusModal';

export function CheckStatusModal() {
    const dispatch = useDispatch();
    const {status, fetchStatus} = useSelector(state => state.request);

    const {
        loadingStatus, error
    } = fetchStatus;

    let template;
    let header;

    switch (loadingStatus) {
        case 'idle':
            header = 'Проверка статуса заявки'
            template = <CheckStatusForm/>
            break;
        case 'loading':
            header = 'Получаю статус заявки'
            template = <CircularProgress/>
            break;
        case 'success':
            const text = (
                <div className={styles.textBlock}>
                    <span>
                        {'Статус вашей заявки: '}
                    </span>
                    <span
                        style={{
                            color: '#E47A3D',
                        }}
                    >
                        {status}
                    </span>
                </div>
            )
            header = 'Проверка статуса заявки'
            template = text
            break;
        case 'failed':
            header = 'Ошибка'
            template = 'Проверьте корректность заполнения'
            break;
    }
    return (
        <div className={styles.checkStatusModal}>
            <header>
                <h2>{header}</h2>
                <GrClose
                    className={styles.closeButton}
                    onClick={() => {
                        dispatch(closeModal());
                        dispatch(clearFetchStatus());
                    }}
                />
            </header>
            {template}
        </div>
    );
}
