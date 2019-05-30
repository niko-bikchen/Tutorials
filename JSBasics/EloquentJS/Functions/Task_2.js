
console.log(isEven(50));
console.log(isEven(75));
console.log(isEven(-1));
console.log(isEven(-18));

function isEven(number) {
    if (Math.abs(number) == 1) {
        return false;
    } else if (Math.abs(number) == 0) {
        return true;
    }

    return isEven(Math.abs(number) - 2);
}