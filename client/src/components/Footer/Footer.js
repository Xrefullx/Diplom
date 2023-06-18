import React from "react";

import styles from './Footer.module.css'

export function Footer() {
    return (
        <footer className={styles.footer}>
            <div className={styles.footerContainer}>
                <img
                    src='https://static.tildacdn.com/tild3566-6237-4032-b134-613634366438/image.png'
                    alt='logo'
                />
                <span className={styles.copyright}>
                    © Все права защищены
                </span>
            </div>
        </footer>
    )
}