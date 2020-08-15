import React, { Component } from 'react';
import './Pokename.css';

class Pokename extends Component {
    static defaultProps = {
        pokename: 'N/A',
    };

    render() {
        return <div className="Pokename">{this.props.pokename}</div>;
    }
}

export default Pokename;
