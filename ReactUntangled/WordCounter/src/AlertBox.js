import React from 'react';
import { SUCCESS, FAILURE, WAITING } from './saveStatus';

function AlertBox({ status }) {
    switch (status) {
        case FAILURE:
            return <div className="mv2">Save FAILED</div>;
        case SUCCESS:
            return <div className="mv2">Save SUCCESSFUL</div>;
        case WAITING:
            return <div className="mv2">Save IN PROCESS</div>;
        default:
            return null;
    }
}

export default AlertBox;