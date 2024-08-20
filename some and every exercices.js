//1. hasOddNumber//

function hasOddNumber(arr) {
    return arr.some(num => num % 2 !== 0);
};

//2. hasAZero

function hasAZero(num) {
    return num.toString().split('').some(char)
};

//3. hasOnlyOddNumbers

function hasOnlyOddNumbers(arr) {
    return arr.every(num => num % 2 !== 0);
};

//4, hasNoDuplicates
function hasNoDuplicates(arr) {
    return arr.length === new Set(arr).size;
};

//5. hasCertainKey
function hasCertainKey(arr, key) {
    return arr.every(obj => obj.hasOwnProperty(key));
};

//6. hasCertainValue
function hasCertainValue(arr, key, value) {
    return arr.every(obj => obj[key === value]);
};

