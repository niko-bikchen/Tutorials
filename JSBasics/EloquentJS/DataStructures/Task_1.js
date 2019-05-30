console.log(range(1, 10, 2));
console.log(sum(range(1, 10)));
console.log(range(5, 2, -1));


function range(begin, end, step = 1) {
    var arr = [];

    for (let i = begin; step > 0 ? i <= end : i >= end; i += step) {
        arr.push(i);
    }

    return arr;
}

function sum(arr) {
    var sum = 0;

    for(let i = 0; i < arr.length; ++i) {
        sum += arr[i];
    }

    return sum;
}