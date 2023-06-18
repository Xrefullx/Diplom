import {useDispatch, useSelector} from 'react-redux'

import CircularProgress from '@mui/material/CircularProgress'
import {GrClose} from "react-icons/gr";

import {NewRequestForm} from '../../containers/NewRequestForm/NewRequestForm'

import styles from './NewRequestModal.module.css'

import {closeModal} from "../../redux/slices/modalSlice";
import {clearFetchStatus} from "../../redux/slices/requestSlice";

export const NEW_REQUEST_MODAL_ID = 'NewRequestModal';

export function NewRequestModal() {
    const dispatch = useDispatch()
    const {id, fetchStatus} = useSelector(state => state.request);

    const {
        loadingStatus, error
    } = fetchStatus;

    let template;
    let header;

    switch (loadingStatus) {
        case 'idle':
            header = 'Оформление заявки'
            template = <NewRequestForm/>
            break;
        case 'loading':
            header = 'Отправляю заявку'
            template = <CircularProgress className={styles.loadingCircular}/>
            break;
        case 'success':
            header = 'Оформление заявки'
            const text = (
                <div className={styles.textBlock}>
                    <span>
                        {'Ваша заявка создана её номер: '}
                    </span>
                    <span
                        style={{
                            color: '#E47A3D',
                        }}
                    >
                        {id}
                    </span>
                </div>
            )
            template = text
            break;
        case 'failed':
            header = 'Ошибка'
            template = (
                <div className={styles.textBlock}>
                    <span>
                        {error.type}
                    </span>
                    <span>
                        {error.message}
                    </span>
                </div>
            )
            break;
    }
    return (
        <div className={styles.newRequestModal}>
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
    )
    // return template;

}