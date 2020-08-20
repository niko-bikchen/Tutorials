import React, { Component } from 'react';

class NewTodoForm extends Component {
    constructor(props) {
        super(props);

        this.state = {
            todo: ''
        }

        this.handleInputChange = this.handleInputChange.bind(this);
        this.addNewTodo = this.addNewTodo.bind(this);
    }
    addNewTodo(event) {
        event.preventDefault();

        this.props.addNewTodo(this.state.todo);

        this.setState({ todo: '' });
    }
    handleInputChange(event) {
        this.setState({ [event.target.name]: event.target.value });
    }
    render() {
        return <form className="NewTodoForm" onSubmit={this.addNewTodo}>
            <label htmlFor="todo">New Todo </label>
            <input onChange={this.handleInputChange} value={this.state.todo} name="todo" id="todo" type="text"></input>
            <button type="submit">Add</button>
        </form>
    }
}

export default NewTodoForm;