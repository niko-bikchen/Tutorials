import React from 'react';
import { Route, Switch, NavLink } from 'react-router-dom';
import VendingMachine from './VendingMachine';
import Apple from './Apple';
import Banana from './Banana';
import Potato from './Potato';
import './App.css';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <NavLink exact to="/" className="header-item" activeClassName="active-nav-item">Home</NavLink>
        <NavLink exact to="/apple" className="header-item" activeClassName="active-nav-item">Apple</NavLink>
        <NavLink exact to="/banana" className="header-item" activeClassName="active-nav-item">Banana</NavLink>
        <NavLink exact to="/potato" className="header-item" activeClassName="active-nav-item">Potato</NavLink>
      </header>
      <div className="App-pages">
        <Switch>
          <Route exact path="/" component={VendingMachine} />
          <Route exact path="/apple" component={Apple} />
          <Route exact path="/banana" component={Banana} />
          <Route exact path="/potato" component={Potato} />
        </Switch>
      </div>
    </div>
  );
}

export default App;
