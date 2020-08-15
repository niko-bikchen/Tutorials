import React, { Component } from 'react';
import './Pokestats.css';

class Pokestats extends Component {
    static defaultProps = {
        pokestats: {
            exp: 0,
        },
    };

    render() {
        const pokestats = this.props.pokestats;

        return (
            <div className="Pokestats">
                <ul className="Pokestats-PokestatsList">
                    {Object.keys(pokestats).map((statName) => (
                        <li key={statName}>
                            {`${statName.toUpperCase()}: ${
                                pokestats[statName]
                            }`}
                        </li>
                    ))}
                </ul>
            </div>
        );
    }
}

export default Pokestats;
