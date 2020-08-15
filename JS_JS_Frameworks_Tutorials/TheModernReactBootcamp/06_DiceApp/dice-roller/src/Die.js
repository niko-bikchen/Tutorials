import React, { Component } from 'react';
import './Die.css';

class Die extends Component {
    static defaultProps = {
        rolling: false,
    };

    render() {
        return (
            <span
                className={`Die fas fa-dice-${this.props.face} ${
                    this.props.rolling && 'Die-wobble'
                }`}
            ></span>
        );
    }
}

export default Die;
