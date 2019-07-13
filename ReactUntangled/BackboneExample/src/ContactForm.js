import React from 'react';
import TextInput from './TextInput';

class ContactForm extends React.Component {
    constructor() {
        super();
        this.form = {};
        this.save = this.save.bind(this);
    }

    save() {
        this.props.onSubmit(this.form);
    }

    update(key) {
        return function (event) {
            this.form[key] = event.target.value;
        }.bind(this);
    }

    render() {
        return (
            <form>
                <h2>Add contact</h2>
                <TextInput label="Name" changed={this.update('name')} />
                <TextInput label="Address" changed={this.update('address')} />
                <TextInput label="ZIP" changed={this.update('zip')} />
                <TextInput label="Email" changed={this.update('email')} />
                <button type="button" onClick={this.save}>Save</button>
            </form>
        );
    }
}

export default ContactForm;