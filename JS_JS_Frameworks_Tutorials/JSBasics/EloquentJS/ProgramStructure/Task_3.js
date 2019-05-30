



createChessboard();





function createChessboard(size = 8) {
    let line = '';
    for (let i = 0; i < size; ++i) {
        line = '';
        for (let j = 0; j < size; ++j) {
            if ((j + i) % 2 == 0) {
                line += '#';
            } else {
                line += ' ';
            }
        }
        console.log(line);
    }
}