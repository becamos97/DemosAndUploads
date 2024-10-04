Given this function:
// function filterOutOdds() {
//   var nums = Array.prototype.slice.call(arguments);
//   return nums.filter(function(num) {
//     return num % 2 === 0
//   });
// }

//Refactor it to use the rest operator & an arrow function:
const filterOutOdds = (...nums) => nums.filter(num => % 2 === 0);


// Write a function called findMin that accepts a variable number of arguments and returns the smallest argument.

// Make sure to do this using the rest and spread operator.

const findMin = (...args) => Math.min(...args);

//Write a function called mergeObjects that accepts two objects and returns a new object which
// contains all the keys and values of the first object and second object.

const mergeObjects = (obj1, obj2) => ({ ...obj1, ...obj2 });

//Write a function called doubleAndReturnArgs which accepts an array and a variable number of arguments.
// The function should return a new array with the original array values and all of additional arguments doubled.

const doubleAndReturnArgs = (arr, ...args) => [...arr, ...args.maps(num => * 2)];

//For this section, write the following functions using rest, spread and refactor these functions to be arrow functions!
//Make sure that you are always returning a new array or object and not modifying the existing inputs.

const removeRandom = items => {
    const index = Math.floor(Math.random() * items.length); //remove a random element from an array
    return [...items.slice(0, index), ...items.slice(index + 1)];
};

const extend = (array1, array2) => [...array1, ...array2]; // combine two arrays

const addKeyVal = (obj, key, val) => ({ ...obj, [key]: val }); // add a key value pair to an object

const removeKey = (obj, key) => {
    const { [key]: _, ...newObj } = obj; //remove a key from an object
    return newObj;
};

const combine = (obj1, obj2) => ({ ...obj1, ...obj2 });// combine two objects

const update = (obj, key, val) => ({ ...obj, [key]: val });// update a key value pair in an object