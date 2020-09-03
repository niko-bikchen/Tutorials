import React, { Component } from 'react';
import { Link } from 'react-router-dom';

class Potato extends Component {
    render() {
        return (
            <div className="Potato">
                <h1>
                    Have some
                    <br/>
                    <span role="img" aria-label="Potato">🥔</span>
                    <i> potato </i>
                    <span role="img" aria-label="Potato">🥔</span>
                </h1>
                <p>
                    <Link to="/" className="link-to-home">
                        <span role="img" aria-label="Back">🔙</span>
                        <b> Take Me Back </b>
                        <span role="img" aria-label="Back">🔙</span>
                    </Link>
                </p>
            </div>
        );
    }
}

export default Potato;