import React, { Component } from 'react';

class RandomClicker extends Component {
    constructor(props) {
        // Initializing React component
        super(props);

        // Initializing state
        this.state = {
            randomNumber: 1,
        };

        // Binding functions
        this.generateRandomNumber = this.generateRandomNumber.bind(this);
    }

    // Generates a random number from 1 to 10
    generateRandomNumber() {
        this.setState({ randomNumber: Math.floor(Math.random() * 10) + 1 });
    }

    render() {
        return (
            <div className="RandomClicker">
                <h1>You random number is: {this.state.randomNumber}</h1>
                {(() => {
                    if (this.state.randomNumber === 7) {
                        return <h2>You Win!</h2>;
                    } else {
                        return (
                            <button onClick={this.generateRandomNumber}>
                                Generate Random Number
                            </button>
                        );
                    }
                })()}
            </div>
        );
    }
}

export default RandomClicker;
