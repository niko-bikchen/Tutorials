import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import './DogList.css';

export class DogList extends Component {
    render() {
        return (
            <div className="DogList">
                <h1 className="display-1 my-3">Dog List!</h1>
                <div className="row">
                    {this.props.dogs.map(dog => (
                        <div className="col-lg-4 Dog" key={dog.name}>
                            <img src={dog.src} alt={dog.name} />
                            <h3>
                                <Link to={`/dogs/${dog.name.toLowerCase()}`} className="underline">
                                    {dog.name}
                                </Link>
                            </h3>
                        </div>
                    ))}
                </div>
            </div>
        )
    }
}

export default DogList;
