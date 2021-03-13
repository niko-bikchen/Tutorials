import React from 'react';

import Paper from '@material-ui/core/Paper';
import List from '@material-ui/core/List';
import Divider from '@material-ui/core/Divider';

import Todo from './Todo';

function TodoList({ todos, removeTodo, toggleTodo, editTodo }) {
  if (todos.length) {
    return (
      <Paper>
        <List>
          {todos.map(({ id, task, completed }, index) => (
            <>
              <Todo
                id={id}
                task={task}
                key={id}
                completed={completed}
                removeTodo={removeTodo}
                toggleTodo={toggleTodo}
                editTodo={editTodo}
              />
              {index < todos.length - 1 && <Divider />}
            </>
          ))}
        </List>
      </Paper>
    );
  }
  return null;
}

export default TodoList;
