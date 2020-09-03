import React, { Component } from 'react';
import axios from 'axios';
import Card from './Card';
import './CardDealer.css';

class CardDealer extends Component {
    static defaultProps = {
        newDeckUrl: 'https://deckofcardsapi.com/api/deck/new/shuffle/'
    }
    constructor(props) {
        super(props);

        this.state = {
            nextCardUrl: '',
            deck: []
        }

        this.drawNewCard = this.drawNewCard.bind(this);
        this.renderDeck = this.renderDeck.bind(this);
    }
    render() {
        const deckIsFull = this.state.deck.length >= 52;

        return (
            <div className="CardDealer">
                <h1 className="CardDealer-title">
                    I am a card dealer!
                </h1>
                <div className="CardDealer-deckWrapper">
                    <div className="CardDealer-deck">
                        {this.renderDeck()}
                    </div>
                </div>
                <button className={deckIsFull ? 'CardDealer-buttonDisabled' : 'CardDealer-button'} onClick={deckIsFull ? null : this.drawNewCard} disabled={deckIsFull}>
                    {deckIsFull ? 'Out of cards' : 'Gimme a card!'}
                </button>
            </div>
        )
    }
    componentDidMount() {
        axios.get(this.props.newDeckUrl).then((response) => {
            this.setState({
                nextCardUrl: `https://deckofcardsapi.com/api/deck/${response.data.deck_id}/draw/`
            });
        }).catch(function handleError(error) {
            console.error(error);
        });
    }
    drawNewCard() {
        axios.get(this.state.nextCardUrl).then((response) => {
            var cardData = response.data.cards[0];

            this.setState(function addNewCard(prevState) {
                return {
                    deck: [...prevState.deck, {
                        cardPic: cardData.image,
                        cardName: `${cardData.value}-${cardData.suit}`,
                        cardStyle: {
                            zIndex: prevState.deck.length + 1,
                            transform: `rotate(${this.randomAngle()}) translate(${this.randomDistance()}, ${this.randomDistance()})`
                        }
                    }]
                }
            });
        }).catch(function handleError(error) {
            console.error(error);
        });
    }
    renderDeck() {
        var { deck } = this.state;

        if (deck.length === 0) {
            return <span role="img" aria-label="You have no cards at the moment" style={{ fontSize: '2em' }}>🤷‍♂️</span>
        } else {
            return deck.map(function createCard(cardData, cardIndex) {
                return <Card key={cardIndex} cardName={cardData.cardName} cardPic={cardData.cardPic} cardStyle={cardData.cardStyle} />
            });
        }
    }
    randomAngle() {
        var angle = Math.floor(Math.random() * 60) + 1;

        return Math.random() < 0.5 ? `${-angle}deg` : `${angle}deg`;
    }
    randomDistance() {
        var distance = Math.floor(Math.random() * 40) + 1;

        return Math.random() < 0.5 ? `${-distance}px` : `${distance}px`;
    }
}

export default CardDealer;