import React, { Component } from 'react';
import './RuleRow.css'

class RuleRow extends Component {
  render() {
    const score = this.props.score;

    return (
      <tr className={`RuleRow ${score === undefined ? 'RuleRow-active' : 'RuleRow-disabled'}`} onClick={this.props.doScore}>
        <td className="RuleRow-name">{this.props.name}</td>
        <td className="RuleRow-score">{score === undefined ? this.props.description : score}</td>
      </tr>
    )
  }
}

export default RuleRow;