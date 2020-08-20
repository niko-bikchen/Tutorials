import React, { Component } from 'react';
import uuid from 'uuid/dist/v4';
import NewTodoForm from './NewTodoForm';
import Todo from './Todo';

class TodoList extends Component {
    constructor(props) {
        super(props);

        this.state = {
            todos: []
        }

        this.renderTodos = this.renderTodos.bind(this);
        this.addNewTodo = this.addNewTodo.bind(this);
        this.deleteTodo = this.deleteTodo.bind(this);
        this.updateTodo = this.updateTodo.bind(this);
    }
    renderTodos() {
        return this.state.todos.map((todo) => {
            return (<Todo key={todo.id} id={todo.id} todo={todo.todo} deleteTodo={this.deleteTodo} updateTodo={this.updateTodo} />)
        });
    }
    addNewTodo(todo) {
        this.setState(function updateTodosList(oldState) {
            return {
                todos: [...oldState.todos, { todo, id: uuid() }]
            }
        });
    }
    deleteTodo(todoId) {
        this.setState(function filterOutTodo(oldState) {
            return {
                todos: oldState.todos.filter(function idIsEqual(todo) {
                    return todo.id !== todoId;
                })
            }
        });
    }
    updateTodo(todoId, newTodo) {
        var todos = [...this.state.todos];

        for (let todo of todos) {
            if (todo.id === todoId) {
                todo.todo = newTodo
            }
        }

        this.setState({
            todos
        });
    }
    render() {
        return (
            <div className="TodoList">
                <NewTodoForm addNewTodo={this.addNewTodo} />
                <div className="TodoList-todos">
                    {this.renderTodos()}
                </div>
            </div>
        )
    }
}

export default TodoList;