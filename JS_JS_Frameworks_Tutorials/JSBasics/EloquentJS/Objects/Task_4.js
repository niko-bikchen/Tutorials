function Seq(arr) {
    this.contents = arr;
    this.pointer = 0;
}
Seq.prototype.start = function () {
    this.pointer = 0;
}
Object.defineProperty(Seq.prototype, 'end', {
    get: function () { return this.pointer == this.contents.length; }
});
Object.defineProperty(Seq.prototype, 'next', {
    get: function () { return this.contents[this.pointer++]; }
});


function ArraySeq(arr) {
    Seq.call(this, arr);
}
ArraySeq.prototype = Object.create(Seq.prototype);


function RangeSeq(from, to) {
    this.from = from;
    this.to = to;
    this.current = from;
}
RangeSeq.prototype = Object.create(Seq.prototype);
Object.defineProperty(RangeSeq.prototype, 'end', {
    get: function () { return this.current == this.to; }
});
Object.defineProperty(RangeSeq.prototype, 'next', {
    get: function () { return this.current++; }
});


function logFive(seq) {
    var counter = 0;
    while (!seq.end && counter < 5) {
        console.log(seq.next);
        counter++;
    }
}

logFive(new ArraySeq([1, 2]));
// → 1
// → 2
logFive(new RangeSeq(100, 1000));
// → 100
// → 101
// → 102
// → 103
// → 104