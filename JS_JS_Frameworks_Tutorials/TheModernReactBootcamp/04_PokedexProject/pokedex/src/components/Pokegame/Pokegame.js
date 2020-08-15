import React, { Component } from 'react';
import './Pokegame.css';
import Pokedex from '../Pokedex/Pokedex.js';

class Pokegame extends Component {
    static defaultProps = {
        pokemons: [
            { id: 4, name: 'Charmander', type: 'fire', base_experience: 62 },
            { id: 7, name: 'Squirtle', type: 'water', base_experience: 63 },
            { id: 11, name: 'Metapod', type: 'bug', base_experience: 72 },
            {
                id: 12,
                name: 'Butterfree',
                type: 'flying',
                base_experience: 178,
            },
            { id: 25, name: 'Pikachu', type: 'electric', base_experience: 112 },
            { id: 39, name: 'Jigglypuff', type: 'normal', base_experience: 95 },
            { id: 94, name: 'Gengar', type: 'poison', base_experience: 225 },
            { id: 133, name: 'Eevee', type: 'normal', base_experience: 65 },
        ],
    };

    getRandomSubarray(arr, n) {
        var result = new Array(n),
            len = arr.length,
            taken = new Array(len);

        if (n > len)
            throw new RangeError(
                'getRandomSubarray: more elements taken than available'
            );

        while (n--) {
            var x = Math.floor(Math.random() * len);
            result[n] = arr[x in taken ? taken[x] : x];
            taken[x] = --len in taken ? taken[len] : len;
        }
        return result;
    }

    render() {
        const pokemons1 = this.getRandomSubarray(this.props.pokemons, 4);
        const pokemons2 = this.props.pokemons.filter(
            (pokemon) => !pokemons1.includes(pokemon)
        );

        const pokemons1Score = pokemons1.reduce(
            (accumulator, current) => accumulator + current.base_experience,
            0
        );
        const pokemons2Score = pokemons2.reduce(
            (accumulator, current) => accumulator + current.base_experience,
            0
        );

        return (
            <div className="Pokegame">
                <Pokedex
                    pokemons={pokemons1}
                    isWinner={pokemons1Score > pokemons2Score}
                />
                <div className="Pokegame-score">
                    Total score: {pokemons1Score}
                </div>
                <hr />
                <Pokedex
                    pokemons={pokemons2}
                    isWinner={pokemons1Score < pokemons2Score}
                />
                <div className="Pokegame-score">
                    Total score: {pokemons2Score}
                </div>
            </div>
        );
    }
}

export default Pokegame;
