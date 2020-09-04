import React, { Component } from 'react';
import { NavLink, Link } from 'react-router-dom';

class Navbar extends Component {
    render() {
        const dogLinks = this.props.dogs.map((dog) => (
            <li className="nav-item" key={dog.name}>
                <NavLink to={`/dogs/${dog.name.toLowerCase()}`} className="nav-link">
                    {dog.name}
                </NavLink>
            </li>
        ))

        return (
            <nav className="navbar navbar-expand-lg navbar-dark bg-dark">
                <Link className="navbar-brand" to="/dogs" >
                    Doggies
                </Link >
                <button className="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span className="navbar-toggler-icon"></span>
                </button>
                <div className="collapse navbar-collapse" id="navbarNav">
                    <ul className="navbar-nav">
                        <li className="nav-item">
                            <NavLink exact className="nav-link" to="/dogs" key="home">Home</NavLink>
                        </li>
                        {dogLinks}
                    </ul>
                </div>
            </nav >
        )
    }
}

export default Navbar;
