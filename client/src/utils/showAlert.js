import React from "react";
import {renderToString} from "react-dom/server";

import {Alert} from '../components/Alert/Alert'

export function showAlert(text) {
    const div = document.createElement('div');
    div.innerHTML = renderToString(
        <Alert
            text={text}
            style={{
                position: 'fixed',

                width: '150px',

                top: '20px',
                backgroundColor: '#f5f5f5',
                color: 'black',

                border: '3px solid #E47A3D',
                borderRadius: '10px',

                padding: '10px',
                zIndex: 3,
            }}
        />
    )

    const alert = div.firstChild;
    document.body.appendChild(alert);

    setTimeout(() => {
            alert.remove()
        },
        1500
    )
}