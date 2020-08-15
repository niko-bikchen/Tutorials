import React, { Component } from 'react';
import '../assets/styles/BoxesContainer.css';
import Box from './Box';

class BoxesContainer extends Component {
    static defaultProps = {
        boxesCount: 14,
    };
    render() {
        return (
            <div className="BoxesContainer">
                {[...Array(this.props.boxesCount)].map(function renderBox(
                    element,
                    index
                ) {
                    return <Box key={index} />;
                })}
            </div>
        );
    }
}

export default BoxesContainer;
