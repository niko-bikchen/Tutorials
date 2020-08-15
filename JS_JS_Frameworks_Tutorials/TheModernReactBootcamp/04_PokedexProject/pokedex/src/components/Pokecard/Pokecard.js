import React, { Component } from 'react';
import './Pokecard.css';
import Pokename from '../Pokename/Pokename.js';
import Pokepic from '../Pokepic/Pokepic.js';
import Poketype from '../Poketype/Poketype.js';
import Pokestats from '../Pokestats/Pokestats.js';

class Pokecard extends Component {
    render() {
        const pokedata = this.props.pokedata;

        return (
            <div className="Pokecard">
                <Pokename pokename={pokedata.name} />
                <Pokepic pokename={pokedata.name} pokeid={pokedata.id} />
                <Poketype poketype={pokedata.type} />
                <Pokestats pokestats={{ exp: pokedata.base_experience }} />
            </div>
        );
    }
}

export default Pokecard;
