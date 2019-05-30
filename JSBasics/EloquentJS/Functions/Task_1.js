

console.log(min(10, 5));
console.log(min(-1, 5));
console.log(min(12, 20));
console.log(min(100, 99));
console.log(min(100, 100));


function min(a, b) {
    return a < b ? a : b < a ? b : 'equal';
}