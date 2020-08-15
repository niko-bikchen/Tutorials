import React, { Component } from 'react';
import Cell from './Cell';
import './Board.css';

class Board extends Component {
  static defaultProps = {
    nRows: 5,
    nColumns: 5,
    litProbability: 0.4,
  };

  constructor(props) {
    super(props);

    this.state = {
      gameIsWon: false,
      gameBoard: this.createBoard(
        this.props.nRows,
        this.props.nColumns,
        this.props.litProbability
      ),
    };

    this.flipCellsAround = this.flipCellsAround.bind(this);
  }

  createBoard(nRows, nColumns, litProbability) {
    var board = [];

    for (let i = 0; i < nRows; i += 1) {
      board.push([]);

      for (let j = 0; j < nColumns; j += 1) {
        let randomNumber = Math.random();

        board[i][j] = litProbability > randomNumber;
      }
    }

    return board;
  }

  flipCellsAround(coord) {
    var { nRows, nColumns } = this.props;
    var board = this.state.gameBoard;
    var [row, column] = coord.split('-').map(Number);

    function flipCell(row, column) {
      if (row >= 0 && row < nRows && column >= 0 && column < nColumns) {
        board[row][column] = !board[row][column];
      }
    }

    flipCell(row, column);
    flipCell(row - 1, column);
    flipCell(row + 1, column);
    flipCell(row, column - 1);
    flipCell(row, column + 1);

    {
      let gameIsWon = board.every((row) => row.every((cell) => !cell));

      this.setState({ gameBoard: board, gameIsWon });
    }
  }

  render() {
    var gameIsWon = this.state.gameIsWon;

    return (
      <div className="Board">
        <table
          className="Board-gameBoard"
          style={{ display: gameIsWon ? 'none' : 'flex' }}
        >
          <tbody>
            {this.state.gameBoard.map((row, rowIndex) => {
              return (
                <tr key={`row-${rowIndex}`}>
                  {row.map((isLit, columnIndex) => {
                    var cellId = `${rowIndex}-${columnIndex}`;

                    return (
                      <Cell
                        key={cellId}
                        isLit={isLit}
                        coordinates={cellId}
                        cellFlipper={this.flipCellsAround}
                      />
                    );
                  })}
                </tr>
              );
            })}
          </tbody>
        </table>
        <h1 style={{ display: gameIsWon ? 'initial' : 'none' }}>You Win!</h1>
      </div>
    );
  }
}

export default Board;
