import React, { Component } from 'react';
import { Link } from 'react-router-dom';

class Banana extends Component {
    render() {
        return (
            <div className="Banana">
                <h1>
                    Have some
                    <br/>
                    <span role="img" aria-label="Banana">🍌</span>
                    <i> banana </i>
                    <span role="img" aria-label="Banana">🍌</span>
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

export default Banana;