import Backbone from 'backbone';
import Contact from './Contact';

const ContactCollection = Backbone.Collection.extend({
    model: Contact
});

export default ContactCollection;