import React, { Component } from 'react';
import axios from 'axios';
import Joke from './Joke';
import './JokesList.css';

class JokesList extends Component {
    static defaultProps = {
        numJokesToGet: 10
    }
    constructor(props) {
        super(props);

        this.state = {
            jokes: JSON.parse(localStorage.getItem("jokes") || "[]"),
            loading: false
        };

        this.handleClick = this.handleClick.bind(this);

        this.seenJokes = new Set(this.state.jokes.map(function getJokeId(joke) { return joke.id; }));
    }
    render() {
        var jokes = this.state.jokes.sort(function sortByVotes(a, b) { return b.votes - a.votes });

        if (!this.state.loading) {
            return (
                <div className="JokeList">
                    <div className="JokeList-sidebar">
                        <h1 className="JokeList-title">
                            <span>Dad</span> Jokes
                        </h1>
                        <img src='https://assets.dryicons.com/uploads/icon/svg/8927/0eb14c71-38f2-433a-bfc8-23d9c99b3647.svg' alt="Laughting emoji" />
                        <button className="JokeList-getmore" onClick={this.handleClick}>
                            New Jokes
                        </button>
                    </div>
                    <div className="JokeList-jokes">
                        {jokes.map((joke) => {
                            return <Joke key={joke.id} text={joke.text} votes={joke.votes} upvote={() => this.handleVote(joke.id, 1)} downvote={() => this.handleVote(joke.id, -1)} />
                        })}
                    </div>
                </div>
            );
        } else {
            return (
                <div className="JokeList-spinner">
                    <span className="far fa-8x fa-laugh fa-spin"></span>
                    <h1 className="JokeList-title">Loading</h1>
                </div>
            );
        }
    }
    componentDidMount() {
        if (this.state.jokes.length === 0) {
            this.getJokes();
        }
    }
    async getJokes() {
        try {
            var jokes = [];

            while (jokes.length < this.props.numJokesToGet) {
                let res = await axios.get('https://icanhazdadjoke.com/', {
                    headers: {
                        Accept: 'application/json'
                    }
                });

                if (!this.seenJokes.has(res.data.id)) {
                    jokes.push({ id: res.data.id, text: res.data.joke, votes: 0 });
                    this.seenJokes.add(res.data.id);
                } else {
                    console.log('FOUND DUPLICATE');
                    console.log(res.data.joke);
                }
            }

            this.setState((prevState) => {
                return {
                    loading: false,
                    jokes: [...prevState.jokes, ...jokes]
                }
            }, () => localStorage.setItem("jokes", JSON.stringify(this.state.jokes)));
        } catch (e) {
            alert(e);

            this.setState({
                loading: false
            });
        }
    }
    handleClick() {
        this.setState({
            loading: true
        }, this.getJokes);
    }
    handleVote(id, delta) {
        this.setState(function updateVotes(prevState) {
            return {
                jokes: prevState.jokes.map(function updateJokeVotes(joke) {
                    return joke.id === id ? { ...joke, votes: joke.votes + delta } : joke;
                })
            }
        }, () => localStorage.setItem("jokes", JSON.stringify(this.state.jokes)));
    }
}

export default JokesList