import React from 'react';
import TextField from '@material-ui/core/TextField';
import useInputState from './hooks/useInputState';

function EditTodoForm({ editTodo, id, task, toggle }) {
  const [value, handleChange, reset] = useInputState(task);

  return (
    <form
      onSubmit={(evt) => {
        evt.preventDefault();
        editTodo(id, value);
        reset();
        toggle();
      }}
      style={{ marginLeft: '1rem', width: '50%' }}
    >
      <TextField
        margin="normal"
        value={value}
        onChange={handleChange}
        fullWidth
        autoFocus
      />
    </form>
  );
}

export default EditTodoForm;
