import React from 'react';
import ContactCard from './ContactCard';

function ContactList({ contacts }) {
    const contactCards = contacts.map(contact =>
        <ContactCard contact={contact} key={contact.cid} />
    );
    return (
        <div>
            <h1>Contacts</h1>
            {contactCards}
        </div>
    );
}

export default ContactList;