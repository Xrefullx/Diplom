import {useDispatch} from "react-redux";
import {useState} from "react";

import {checkRequest} from '../../redux/slices/requestSlice'
import styles from './CheckStatusForm.module.css'

export function CheckStatusForm() {
    const dispatch = useDispatch();
    const [requestId, setRequestId] = useState('');

    const handleSubmit = (event) => {
        event.preventDefault();
        dispatch(checkRequest({
            id: requestId
        }))
    }

    return (
        <form className={styles.form}>
            <input
                type='text'
                placeholder='Введите номер заявки'
                value={requestId}
                onChange={(event) => {
                    setRequestId(event.target.value);
                }}
            />
            <input
                type='submit'
                value='Проверить заявку'
                onClick={handleSubmit}
            />
        </form>
    )
}