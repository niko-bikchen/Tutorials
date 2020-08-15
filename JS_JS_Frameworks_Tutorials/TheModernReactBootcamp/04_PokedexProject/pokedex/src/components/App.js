import React, { Component } from 'react';
import './App.css';
// import Pokedex from '../components/Pokedex/Pokedex.js';
import Pokegame from '../components/Pokegame/Pokegame.js';

class App extends Component {
    render() {
        return (
            <div>
                {/* <Pokedex /> */}
                <Pokegame />
            </div>
        );
    }
}

export default App;
