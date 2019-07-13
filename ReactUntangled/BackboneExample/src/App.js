import React from 'react';
import ContactForm from './ContactForm';
import ContactList from './ContactList';

class App extends React.Component {
    constructor(props) {
        super(props);
        this.state = { data: [] };
        this.addElement = this.addElement.bind(this);
        this.props.collection.on('add', () => {
            this.setState(() => ({ data: this.props.collection.toJSON() }));
        });
    }

    addElement(item) {
        this.props.collection.add(item);
    }

    render() {
        return (
            <div>
                <ContactList contacts={this.state.data} />
                <ContactForm onSubmit={this.addElement} />
            </div>
        );
    }
}

export default App;