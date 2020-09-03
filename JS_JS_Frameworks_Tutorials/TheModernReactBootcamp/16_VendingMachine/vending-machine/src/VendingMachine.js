import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import vendingMachine from './vendmach.png';
import './VendingMachine.css';

class VendingMachine extends Component {
    render() {
        return (
            <div className="VendingMachine">
                <div className="VendingMachine-title">
                    <h1>I am the Vending Machine!</h1>
                </div>
                <div className="VendingMachine-content">
                    <div className="VendingMachine-picture">
                        <img src={vendingMachine} alt="Vending machine" />
                    </div>
                    <div className="VendingMachine-menu">
                        <h2>Would you like some:</h2>
                        <Link to="/apple" className="menu-item">Apple</Link>
                        <Link to="/banana" className="menu-item">Banana</Link>
                        <Link to="/potato" className="menu-item">Potato</Link>
                    </div>
                </div>
            </div>
        );
    }
}

export default VendingMachine;