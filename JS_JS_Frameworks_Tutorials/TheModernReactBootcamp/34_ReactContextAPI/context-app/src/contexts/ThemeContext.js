import React, { Component, createContext } from 'react';

const ThemeContext = createContext();

class ThemeProvider extends Component {
  constructor(props) {
    super(props);
    this.state = {
      isDarkMode: true,
    };
    this.toggleTheme = this.toggleTheme.bind(this);
  }
  toggleTheme() {
    this.setState((state) => {
      return { isDarkMode: !state.isDarkMode };
    });
  }
  render() {
    return (
      <ThemeContext.Provider
        value={{ ...this.state, toggleTheme: this.toggleTheme }}
      >
        {this.props.children}
      </ThemeContext.Provider>
    );
  }
}

export { ThemeProvider, ThemeContext };
