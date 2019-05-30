function deepEqual(a, b) {
    if (a === b) {
        return true;
    } else if ((typeof a == 'object' && a != null) && (typeof b == 'object' && b != null)) {
        if (Object.keys(a).length != Object.keys(b).length) {
            return false;
        }

        for (item in a) {
            if (b.hasOwnProperty(item)) {
                if (!deepEqual(a[item], b[item])) {
                    return false;
                }
            } else {
                return false;
            }
        }

        return true;
    } else {
        return false;
    }
}

var obj = { here: { is: "an" }, object: 2 };

console.log(deepEqual(obj, obj));

console.log(deepEqual(obj, {here: 1, object: 2}));

console.log(deepEqual(obj, {here: {is: "an"}, object: 2}));