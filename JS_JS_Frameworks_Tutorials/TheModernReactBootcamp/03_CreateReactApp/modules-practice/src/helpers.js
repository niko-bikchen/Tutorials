function choice(items) {
    return items[Math.floor(Math.random() * items.length)];
}

function remove(items, item) {
    return items.filter((el) => el !== item);
}

export { remove, choice };
