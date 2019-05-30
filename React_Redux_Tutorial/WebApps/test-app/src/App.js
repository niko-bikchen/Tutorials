import React, { Component } from 'react';
import User from './components/User'
import Navbar from './components/Navbar'
import { connect } from 'react-redux'

class App extends Component {
  constructor() {
    super();
    this.state = {
      currentPage: 1,
      todosPerPage: 5
    };
    this.handleClick = this.handleClick.bind(this);
  }

  handleClick(event) {
    document.getElementById(this.state.currentPage).removeAttribute("class");
    this.setState({
      currentPage: Number(event.target.id)
    });
    document.getElementById(event.target.id).setAttribute("class", "active");
  }

  render() {
    const { currentPage, todosPerPage } = this.state;

    const indexOfLastUser = currentPage * todosPerPage;
    const indexOfFirstUser = indexOfLastUser - todosPerPage;
    const users = this.props.users.slice(indexOfFirstUser, indexOfLastUser);

    const numbers = [];
    for (let i = 1; i <= Math.ceil(this.props.users.length / todosPerPage); i++) {
      numbers.push(i);
    }

    const renderPageNumbers = numbers.map(number => {
      if (number === 1) {
        return (
          <button key={number} id={number} onClick={this.handleClick} className="active">
            {number}
          </button>
        );
      }
      else {
        return (
          <button key={number} id={number} onClick={this.handleClick}>
            {number}
          </button>
        );
      }
    });

    return (
      <div>
        <Navbar />
        <User users={users} />
        <ul className="pagination center">
          {renderPageNumbers}
        </ul>
      </div>
    );
  }
}

const mapStateToProps = (state) => {
  return {
    users: state.users
  }
}

export default connect(mapStateToProps)(App);
