import ReactDOM from 'react-dom';
import React from 'react';
import ContactCollection from './ContactCollection';
import App from './App';

const collection = new ContactCollection();

ReactDOM.render(
    <App collection={collection} />,
    document.getElementById('app')
);