import React, { Component } from 'react';
import '../assets/styles/CoinFlipper.css';
import Coin from '../components/Coin';

class CoinFlipper extends Component {
    constructor(props) {
        super(props);

        this.state = {
            side: 0,
            flipsCount: 0,
            headsCount: 0,
            tailsCount: 0,
        };

        this.flipACoin = this.flipACoin.bind(this);
    }
    flipACoin() {
        var randomSide = Math.floor(Math.random() * 2) + 1;

        this.setState(function updateState(currentState) {
            return {
                side: randomSide,
                flipsCount: currentState.flipsCount + 1,
                headsCount:
                    currentState.headsCount + (randomSide === 1 ? 1 : 0),
                tailsCount:
                    currentState.tailsCount + (randomSide === 2 ? 1 : 0),
            };
        });
    }
    render() {
        return (
            <div className="CoinFlipper">
                <h1 className="CoinFlipper-title">Let's Flip the Coin!</h1>
                <div className="CoinFlipper-coin">
                    {this.state.side !== 0 && <Coin side={this.state.side} />}
                </div>
                <p className="CoinFlipper-stats">
                    Out of {this.state.flipsCount} flips, there have been{' '}
                    {this.state.headsCount} heads and {this.state.tailsCount}{' '}
                    tails.
                </p>
                <div className="CoinFlipper-button">
                    <button onClick={this.flipACoin}>Flip the Coin</button>
                </div>
            </div>
        );
    }
}

export default CoinFlipper;
