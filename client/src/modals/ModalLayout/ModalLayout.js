import {useSelector, useDispatch} from 'react-redux'

import styles from './ModalLaout.module.css'

import {NEW_REQUEST_MODAL_ID, NewRequestModal} from '../NewRequestModal/NewRequestModal'
import {CHECK_STATUS_MODAL_ID, CheckStatusModal} from '../CheckStatusModal/CheckStatusModal'

import {closeModal} from '../../redux/slices/modalSlice';

import {clearFetchStatus} from '../../redux/slices/requestSlice';

export function ModalLayout() {
    const {modal} = useSelector(state => state.modal);
    const dispatch = useDispatch();

    let template;

    switch (modal) {
        case NEW_REQUEST_MODAL_ID:
            template = <NewRequestModal/>
            break;
        case CHECK_STATUS_MODAL_ID:
            template = <CheckStatusModal/>
            break;
        default:
            template = null;
            break;
    }

    return (
        template
            ? (
                <div
                    className={styles.modalLayout}
                    onMouseDown={(event) => {
                        if (event.target.className !== styles.modalLayout)
                            return;
                        dispatch(clearFetchStatus());
                        dispatch(closeModal());
                    }}

                >
                    {template}
                </div>
            )
            : template
    );
}