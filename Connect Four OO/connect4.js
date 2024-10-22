/** Connect Four
 *
 * Player 1 and 2 alternate turns. On each turn, a piece is dropped down a
 * column until a player gets four-in-a-row (horiz, vert, or diag) or until
 * board fills (tie)
 */

const WIDTH = 7;
const HEIGHT = 6;

currPlayer = 1; // active player: 1 or 2
board = []; // array of rows, each row is array of cells  (board[y][x])

class Player {
  constructor(color) { //
    this.color = color; //player color
  }}


class Game {
  constructor(height = 6, width = 7, player1Color = 'red', player2Color = 'blue') { //<Initialize with defaults
    this.height = height; //<set instance for height
    this.width = width; //<set instance width
    this.board = []; //<Initialize empty board array
    this.isGameOver = false; //Tracking if ganme is over
    this.player1 = new Player(player1Color);
    this.player2 = new Player(player2Color);
    this.players = [this.player1, this.player2]; //stores players in Arrays
    this.currPlayer = this.player1; //<start with player 1 

    this.makeBoard();// <create in-Js board array
    this.makeHtmlBoard();//< create HTML game board
  }

/** makeBoard: create in-JS board structure:
 *   board = array of rows, each row is array of cells  (board[y][x])
 */

// makeBoard() {
//   for (let y = 0; y < this.height; y++) { //<Used INSTANCE height
//     this.board.push(Array.from({ length: this.width }));// <Used INSTANCE width
//   }
// };
makeBoard() {
  this.board = Array.from({ length: this.height }, () => Array(this.width).fill(null)); // Part Two recode
}
/** makeHtmlBoard: make HTML table and row of column tops. */

makeHtmlBoard() {
  const board = document.getElementById('board');
  board.innerHTML = '';//< Clearing previous HTML, important if restarting the game

  // make column tops (clickable area for adding a piece to that column)
  const top = document.createElement('tr');
  top.setAttribute('id', 'column-top');
  top.addEventListener('click', this.handleClick.bind(this)); //<Binding 'this' context

  for (let x = 0; x < WIDTH; x++) {
    const headCell = document.createElement('td');
    headCell.setAttribute('id', x);
    top.append(headCell);
  }

  board.append(top);

  // make main part of board
  for (let y = 0; y < this.height; y++) { //<Use instance for height
    const row = document.createElement('tr');

    for (let x = 0; x < this.width; x++) { //<Used instance for width
      const cell = document.createElement('td');
      cell.setAttribute('id', `${y}-${x}`);
      row.append(cell);
    }

    board.append(row);
  }
};

/** findSpotForCol: given column x, return top empty y (null if filled) */

findSpotForCol(x) {
  for (let y = this.height - 1; y >= 0; y--) { //< INSTANCES
    if (!this.board[y][x]) {
      return y;
    }
  }
  return null;
}

/** placeInTable: update DOM to place piece into HTML table of board */

placeInTable(y, x) {
  const piece = document.createElement('div');
  piece.classList.add('piece');
  piece.style.backgroundColor = this.currPlayer.color;
  //piece.classList.add('piece', `p${currPlayer}`); //Combined piece with player class
  piece.style.top = -50 * (y + 2);

  const spot = document.getElementById(`${y}-${x}`);
  spot.append(piece);
}

/** endGame: announce game end */

endGame(msg) {
  alert(msg);
  this.isGameOver = true; //<setting game over to true
  //return this.endGame(msg)
}

/** handleClick: handle click of column top to play piece */

handleClick(evt) {
  if (this.isGameOver) return; // stop moves if game is over
  // get x from ID of clicked cell
  const x = +evt.target.id;

  // get next spot in column (if none, ignore click)
  const y = this.findSpotForCol(x);
  if (y === null) {
    return;
  }

  // place piece in board and add to HTML table
  this.board[y][x] = this.currPlayer;
  this.placeInTable(y, x);
  
  // check for win
  if (this.checkForWin()) {
    this.endGame(`Player with color ${this.currPlayer.color} won!`);//< we are calling the method here
    return; //<Stopping further execution!
  }
  
  // check for tie
  if (this.board.every(row => row.every(cell => cell))) {
    return this.endGame('Tie!');
  }
    
  // switch players
  this.currPlayer = this.currPlayer === this.player1 ? this.player2 : this.player1 ; //alternate players???
}

/** checkForWin: check board cell-by-cell for "does a win start here?" */

checkForWin() {
  const _win = (cells) => {// this is an assignment, _win is a constant
    // Check four cells to see if they're all color of current player
    //  - cells: list of four (y, x) cells
    //  - returns true if all are legal coordinates & all match currPlayer

    return cells.every(
      ([y, x]) =>
        y >= 0 &&
        y < this.height &&
        x >= 0 &&
        x < this.width &&
        this.board[y][x] === this.currPlayer
    );
  };

  for (let y = 0; y < this.width; y++) {
    for (let x = 0; x < this.width; x++) {
      // get "check list" of 4 cells (starting here) for each of the different
      // ways to win
      const horiz = [[y, x], [y, x + 1], [y, x + 2], [y, x + 3]];
      const vert = [[y, x], [y + 1, x], [y + 2, x], [y + 3, x]];
      const diagDR = [[y, x], [y + 1, x + 1], [y + 2, x + 2], [y + 3, x + 3]];
      const diagDL = [[y, x], [y + 1, x - 1], [y + 2, x - 2], [y + 3, x - 3]];

      // find winner (only checking each win-possibility as needed)
      if (_win(horiz) || _win(vert) || _win(diagDR) || _win(diagDL)) {
        return true;
      }
    }
  }
}
}
new Game(6, 7);
// makeBoard();
// makeHtmlBoard();

//button to start new game
document.getElementById('start-btn').addEventListener('click', () => {  //Event listener for start button
  const player1Color = document.getElementById('player1-color').value;  //Gets player 1 color from input
  const player2Color = document.getElementById('player2-color').value;  //Gets player 2 color from input
  new Game(6, 7, player1Color, player2Color);  //Initializes Game with colors
});
