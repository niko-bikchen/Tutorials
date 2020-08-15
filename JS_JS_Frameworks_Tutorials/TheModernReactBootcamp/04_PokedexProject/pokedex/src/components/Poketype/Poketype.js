import React, { Component } from 'react';
import './Poketype.css';

class Poketype extends Component {
    static defaultProps = {
        poketype: 'N/A',
    };

    render() {
        return <div className="Poketype">Type: {this.props.poketype.toUpperCase()}</div>;
    }
}

export default Poketype;
