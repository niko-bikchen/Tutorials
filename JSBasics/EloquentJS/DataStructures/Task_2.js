var array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

console.log(reverseArray(array));
console.log(array);

reverseArrayInPlace(array);
console.log(array);


function reverseArray(array){
    var result = [];

    for(let i = 0; i < array.length; ++i) {
        result[i] = array[array.length - (i + 1)];
    }

    return result;
}

function reverseArrayInPlace(array) {
    var temp = 0;
    for(let i = 0; i < array.length / 2; ++i) {
        temp = array[i];
        array[i] = array[array.length - (i + 1)];
        array[array.length - (i + 1)] = temp;
    }
}