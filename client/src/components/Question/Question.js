import {useState} from "react";
import {GrClose} from 'react-icons/gr';

import styles from './Question.module.css'

export function Question({question, answer}) {
    let [isCollapse, setIsCollapse] = useState(false);

    function changeStatus() {
        setIsCollapse(!isCollapse);
    }

    return (
        <div
            onClick={changeStatus}
            className={[
                styles.question,
                isCollapse ? styles.collapsed : styles.uncollapsed
            ].join(' ')}
        >
            <header>
                <h3>
                    {question}
                </h3>
                <GrClose className={styles.collapseButton}/>
            </header>
            <div className={styles.answer}>
                {answer}
            </div>
        </div>
    )
}