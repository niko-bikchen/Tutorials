import React, { Component } from "react";
import "./Die.css";

class Die extends Component {
  static defaultProps = {
    numberToWord: ['one', 'two', 'three', 'four', 'five', 'six']
  }
  constructor(props) {
    super(props);

    this.handleClick = this.handleClick.bind(this);
  }
  handleClick(evt) {
    this.props.handleClick(this.props.idx);
  }
  render() {
    const val = this.props.val;
    var cssClass = `Die fas fa-dice-${this.props.numberToWord[val - 1]} fa-5x `;

    if (this.props.locked) {
      cssClass += 'Die-locked';
    }

    return (
      <span
        className={cssClass}
        onClick={this.handleClick}
      >
      </span>
    );
  }
}

export default Die;
