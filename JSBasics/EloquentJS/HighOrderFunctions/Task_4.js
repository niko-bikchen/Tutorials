function every(args, callback) {
    for (let i = 0; i < args.length; ++i) {
        if (!callback(args[i])) {
            return false;
        }
    }

    return true;
}

function some(args, callback) {
    for (let i = 0; i < args.length; ++i) {
        if (callback(args[i])) {
            return true;
        }
    }

    return false;
}

console.log(every([NaN, NaN, NaN], isNaN));
// → true
console.log(every([NaN, NaN, 4], isNaN));
// → false
console.log(some([NaN, 3, 4], isNaN));
// → true
console.log(some([2, 3, 4], isNaN));
// → false