import React, { Component } from 'react';
import './Pokepic.css';

class Pokepic extends Component {
    getPicID(pokeId) {
        const id = String(pokeId);

        return id.length >= 3 ? id : `${'0'.repeat(3 - id.length)}${id}`;
    }

    render() {
        return (
            <div className="Pokepic">
                <img
                    className="Pokepic-img"
                    src={`https://assets.pokemon.com/assets/cms2/img/pokedex/detail/${this.getPicID(
                        this.props.pokeid
                    )}.png`}
                    alt={`${this.props.pokename}`}
                    title={`${this.props.pokename}`}
                />
            </div>
        );
    }
}

export default Pokepic;
