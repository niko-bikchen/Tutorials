import React, { Component } from 'react';
import '../assets/styles/Box.css';

class Box extends Component {
    static defaultProps = {
        colors: [
            '#38d1d8',
            '#e27b22',
            '#e45c59',
            '#0bdb40',
            '#6c02de',
            '#7d8e6d',
            '#deda0d',
            '#19ad6f',
            '#dd0949'
        ],
    };
    constructor(props) {
        super(props);

        var randomIndex = Math.floor(Math.random() * this.props.colors.length);
        this.state = {
            boxColor: this.props.colors[randomIndex],
        };

        this.getRandomColor = this.getRandomColor.bind(this);
        this.changeBoxColor = this.changeBoxColor.bind(this);
    }
    getRandomColor() {
        var currentColor = this.state.boxColor;
        var colors = this.props.colors;
        var randomIndex = Math.floor(Math.random() * colors.length);
        var newColor = colors[randomIndex];

        while (newColor === currentColor) {
            randomIndex = Math.floor(Math.random() * colors.length);
            newColor = colors[randomIndex];
        }

        return newColor;
    }
    changeBoxColor() {
        this.setState({ boxColor: this.getRandomColor() });
    }
    render() {
        return (
            <div
                onClick={this.changeBoxColor}
                className="Box"
                style={{ backgroundColor: this.state.boxColor }}
            ></div>
        );
    }
}

export default Box;
