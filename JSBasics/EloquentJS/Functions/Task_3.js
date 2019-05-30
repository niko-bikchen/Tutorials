console.log(countChar('e', "Beans Breakfast ButterB"));

function countChar(char, string) {
    var count = 0;

    for(let i = 0; i < string.length; ++i) {
        if(string.charAt(i) == char) {
            ++count;
        }
    }

    return count;
}