import React from 'react';

function TextInput({ label, changed }) {
    return (
        <label>
            {label}
            <input onChange={changed} />
        </label>
    );
}

export default TextInput;