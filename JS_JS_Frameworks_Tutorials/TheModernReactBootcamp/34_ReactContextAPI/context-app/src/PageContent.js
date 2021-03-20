import React, { Component } from 'react';
import { ThemeContext } from './contexts/ThemeContext';

class PageContent extends Component {
  render() {
    const { isDarkMode } = this.context;
    const styles = {
      backgroundColor: isDarkMode ? '#333' : 'white',
      height: '100vh',
      width: '100vw',
    };

    return <div style={styles}>{this.props.children}</div>;
  }
}
PageContent.contextType = ThemeContext;

export default PageContent;
