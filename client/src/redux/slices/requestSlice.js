import {createSlice, createAsyncThunk} from '@reduxjs/toolkit';

import axios from "axios";

export const checkRequest = createAsyncThunk(
    'checkRequest',
    async ({
               id
           }) => {
        const response = await axios.get(
            `https://help-maxbonus.ru/api/task/status/${id}`
        )

        return response.data.nameStatus;
    }
)

export const sendNewRequest = createAsyncThunk(
    'sendNewRequest',
    async ({
               phone,
               title,
               reasonId,
               email,
               companyName,
               description,
           }) => {
        const response = await axios.post(
            'https://help-maxbonus.ru/api/task/add', {
                phone: phone,
                title: title,
                reasonId: +reasonId,
                email: email,
                companyName: companyName,
                description: description
            })

        return response.data.id;
    }
)

const initState = {
    id: null,
    status: null,
    fetchStatus: {
        loadingStatus: 'idle',
        error: null,
    }
}

const requestSlice = createSlice({
    name: 'request',
    initialState: initState,
    reducers: {
        clearFetchStatus: (state, action) => {
            state.id = null;
            state.status = null;
            state.fetchStatus.loadingStatus = 'idle';
            state.fetchStatus.error = null;
        }
    },
    extraReducers: builder => {
        builder
            .addCase(
                sendNewRequest.pending,
                (state) => {
                    state.id = null;
                    state.fetchStatus.loadingStatus = 'loading';
                    state.fetchStatus.error = null;
                }
            )
            .addCase(
                sendNewRequest.fulfilled,
                (state, action) => {
                    state.id = action.payload;
                    state.fetchStatus.loadingStatus = 'success';
                    state.fetchStatus.error = null;
                }
            )
            .addCase(
                sendNewRequest.rejected,
                (state, action) => {
                    state.id = null;
                    console.error(action.error);
                    state.fetchStatus.loadingStatus = 'failed'
                    state.fetchStatus.error = action.error;
                }
            )



            .addCase(
                checkRequest.pending,
                (state, action) => {
                    state.status = null;
                    state.fetchStatus.loadingStatus = 'loading';
                    state.fetchStatus.error = null;
                }
            )
            .addCase(
                checkRequest.fulfilled,
                (state, action) => {
                    state.status = action.payload;
                    state.fetchStatus.loadingStatus = 'success';
                    state.fetchStatus.error = null;
                }
            )
            .addCase(
                checkRequest.rejected,
                (state, action) => {
                    state.status = null;
                    console.error(action.error);
                    state.fetchStatus.loadingStatus = 'failed';
                    state.fetchStatus.error = action.error;
                }
            )
    }
})

const {actions, reducer} = requestSlice;

export const {
    clearFetchStatus
} = actions

export {reducer as requestReducer};
