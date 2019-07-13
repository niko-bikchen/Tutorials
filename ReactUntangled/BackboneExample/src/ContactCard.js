import React from 'react';

function ContactCard({ contact }) {
    return (
        <dl>
            <dt>Name</dt>
            <dd>{contact.name}</dd>
            <dt>Address</dt>
            <dd>{contact.address}</dd>
            <dt>Post code / ZIP code</dt>
            <dd>{contact.zip}</dd>
        </dl>
    );
}

export default ContactCard;