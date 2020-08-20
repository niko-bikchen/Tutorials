import React, { Component } from 'react';

class Todo extends Component {
    constructor(props) {
        super(props);

        this.state = {
            newTodo: '',
            isEdited: false
        }

        this.handleDelete = this.handleDelete.bind(this);
        this.enableEdit = this.enableEdit.bind(this);
        this.handleInputChange = this.handleInputChange.bind(this);
        this.saveEdit = this.saveEdit.bind(this);
    }
    handleDelete() {
        this.props.deleteTodo(this.props.id)
    }
    enableEdit() {
        this.setState({
            isEdited: true,
            newTodo: this.props.todo
        });
    }
    saveEdit(event) {
        event.preventDefault();

        this.props.updateTodo(this.props.id, this.state.newTodo);

        this.setState({
            isEdited: false,
            newTodo: ''
        });
    }
    handleInputChange(event) {
        this.setState({
            [event.target.name]: event.target.value
        })
    }
    render() {
        return (
            <div className="Todo">
                {!this.state.isEdited ? <span>{this.props.todo}</span> : null}
                {!this.state.isEdited ? <button onClick={this.handleDelete}>Delet This</button> : null}
                {!this.state.isEdited ? <button onClick={this.enableEdit}>Edit This</button> : null}
                {this.state.isEdited ? (<form onSubmit={this.saveEdit}>
                    <input onChange={this.handleInputChange} value={this.state.newTodo} name="newTodo" type="text"></input>
                    <button type="submit">Save</button>
                </form>) : null}
            </div>
        )
    }
}

export default Todo;