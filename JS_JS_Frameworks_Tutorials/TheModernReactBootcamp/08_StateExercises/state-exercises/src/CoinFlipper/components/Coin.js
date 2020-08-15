import React, { Component } from 'react';
import '../assets/styles/Coin.css';
import headsImg from '../assets/images/heads.jpg';
import tailsImg from '../assets/images/tails.jpg';

class Coin extends Component {
    render() {
        return (
            <div className="Coin">
                <img
                    src={this.props.side === 1 ? headsImg : tailsImg}
                    alt={this.props.side === 1 ? 'heads' : 'tails'}
                />
            </div>
        );
    }
}

export default Coin;
