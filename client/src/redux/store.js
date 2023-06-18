import {configureStore} from '@reduxjs/toolkit'

import {modalReducer} from './slices/modalSlice'
import {requestReducer} from './slices/requestSlice'

export const store = configureStore({
    reducer: {
        modal: modalReducer,
        request: requestReducer,
    }
})