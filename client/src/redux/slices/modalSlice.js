import {createSlice} from '@reduxjs/toolkit';

const initState = {
    modal: null,
}

const modalSlice = createSlice({
    name: 'modal',
    initialState: initState,
    reducers: {
        openModal: (state, action) => {
            state.modal = action.payload
        },
        closeModal: (state) => {
            state.modal = null
        }
    }
})

const {actions, reducer} = modalSlice;

export const {
    openModal,
    closeModal
} = actions;

export {reducer as modalReducer};
