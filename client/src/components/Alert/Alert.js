import style from './Alert.module.css'

export function Alert({text}) {
    return (
        <div
            className={style.alert}
        >
            {text}
        </div>
    )
}