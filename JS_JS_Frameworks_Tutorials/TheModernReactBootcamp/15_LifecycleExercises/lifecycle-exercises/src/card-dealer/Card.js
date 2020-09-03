import React, { Component } from 'react';
import './Card.css';

class Card extends Component {
    render() {
        const { cardName, cardPic, cardStyle } = this.props;

        return <img src={cardPic} style={cardStyle} className="Card" alt={cardName}></img>
    }
}

export default Card;