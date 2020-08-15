import React, { Component } from 'react';
import './Lottery.css';
import Ball from './Ball';

class Lottery extends Component {
    static defaultProps = {
        title: 'Lotto',
        maxBalls: 6,
        maxNum: 40,
    };

    constructor(props) {
        super(props);

        this.state = {
            nums: Array.from({ length: this.props.maxBalls }),
        };

        this.handleClick = this.handleClick.bind(this);
        this.generate = this.generate.bind(this);
    }

    generate() {
        this.setState((curState) => ({
            nums: curState.nums.map(
                (n) => Math.floor(Math.random() * this.props.maxNum) + 1
            ),
        }));
    }
    handleClick() {
        this.generate();
    }

    render() {
        return (
            <section className="Lottery">
                <h1>{this.props.title}</h1>
                <div>
                    {this.state.nums.map((num, index) => (
                        <Ball key={index} num={num} />
                    ))}
                </div>
                <br />
                <button onClick={this.handleClick}>Generate</button>
            </section>
        );
    }
}

export default Lottery;
