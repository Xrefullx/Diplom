import {useDispatch} from "react-redux";
import {useState} from "react";

import {sendNewRequest} from '../../redux/slices/requestSlice'

import styles from './NewRequestForm.module.css';

const reasons = [{
    id: 1, nameReason: "Не работает лояльность"
}, {
    id: 2, nameReason: "Проблема с кассой"
}, {
    id: 3, nameReason: "Проблема с акцией"
}, {
    id: 4, nameReason: "Не начисляются бонусы"
}, {
    id: 5, nameReason: "Не предоставляется скидка"
}, {
    id: 6, nameReason: "Необходимость отчёта"
}, {
    id: 7, nameReason: "Другое"
}]


export function NewRequestForm() {
    const dispatch = useDispatch();

    const [phone, setPhone] = useState("");
    const [title, setTitle] = useState("");
    const [reasonId, setReasonId] = useState("");
    const [email, setEmail] = useState("");
    const [companyName, setCompanyName] = useState("");
    const [description, setDescription] = useState("");

    const handleSubmit = (event) => {
        event.preventDefault();

        if (
            !phone
            || !title
            || !reasonId
            || !email
            || !companyName
            || !description
        ) {
            return;
        }

        dispatch(sendNewRequest({
            phone: phone, title: title, reasonId: reasonId, email: email, companyName: companyName,
        }))
    }


    let hasEmptyFields = false;

    if (
        !phone
        || !title
        || !reasonId
        || !email
        || !companyName
    )
        hasEmptyFields = true;


    return (
        <form className={styles.form}>
            <input
                type='text'
                style={!title ? {border: '2px solid #ff6464'} : null}
                placeholder={'* Ваше имя'}
                required
                onChange={(event) => {
                    setTitle(event.target.value);
                }}
            />
            <input
                type='tel'
                value={phone}
                style={!phone ? {border: '2px solid #ff6464'} : null}
                placeholder='* +7 (123) 123-12-12'
                // pattern="\+?[0-9\-\(\)]+"
                required
                onChange={(event) => {
                    setPhone(event.target.value);
                }}
            />
            <input
                type='email'
                style={!email ? {border: '2px solid #ff6464'} : null}
                placeholder='* mail@mail.ru'
                // pattern="([A-z0-9_.-]{1,})@([A-z0-9_.-]{1,}).([A-z]{2,8})"
                required
                onChange={(event) => {
                    setEmail(event.target.value);
                }}
            />
            <select
                required
                style={!reasonId ? {border: '2px solid #ff6464'} : null}
                name='reason'
                value={reasonId}
                onChange={(event) => {
                    setReasonId(event.target.value);
                }}
            >
                <option value="" disabled>* Выберите причину</option>
                {reasons.map((item) => {
                    return (<option
                        key={item.id}
                        value={item.id}
                    >
                        {item.nameReason}
                    </option>)
                })}
            </select>
            <textarea
                type='text'
                style={!description ? {border: '2px solid #ff6464', height: '80px'} : null}
                placeholder={`* Описание проблемы`}
                onChange={(event) => {
                    setDescription(event.target.value);
                }}
                value={description}
            />
            <input
                type='text'
                style={!companyName ? {border: '2px solid #ff6464'} : null}
                placeholder='* Название компании'
                required
                onChange={(event) => {
                    setCompanyName(event.target.value);
                }}
            />
            <input
                type='submit'
                style={
                    hasEmptyFields
                        ? {
                            backgroundColor: '#9f9f9f'
                        }
                        : {}
                }
                value='Оставить заявку'
                onClick={
                    hasEmptyFields
                        ? null
                        : handleSubmit
                }
            />
        </form>
    )
}