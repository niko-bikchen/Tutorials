function arrayToList(array) {
    var head = { value: array[0], next: null };
    var tail = head;

    for (let i = 1; i < array.length; ++i) {
        let node = { value: array[i], next: null };
        tail.next = node;
        tail = node;
    }

    return head;
}

function listToArray(list) {
    var array = [];

    while (list != null) {
        array.push(list.value);
        list = list.next;
    }

    return array;
}

function prepend(list, elem) {
    var newList = {value: elem, next: list};

    return newList;
}

function nth(list, index) {
    if(index == 0) {
        return list == null ? undefined : list.value;
    }

    return nth(list.next, index - 1);
}

console.log(arrayToList([10, 20]));

console.log(listToArray(arrayToList([10, 20, 30])));

var list = arrayToList([4, 5, 6, 7]);
console.log(prepend(list, 3));

console.log(nth(arrayToList([10, 20, 30]), 1));