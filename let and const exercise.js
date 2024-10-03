ES5 Global Constants


var PI = 3.14;
PI = 42; // stop me from doing this!


ES2015 Global Constants

const PI = 3.14;
PI = 42; //It will create and error

What is the difference between var and let? 

//The difference between them is the scope of the variables the create,
//you can reassign and redeclare with var, but you can not redeclare using let. You can also access
//a hoisted variable with var. Let creates block scope

What is the difference between var and const?

//Again you can reassign and redeclare with var but you can not redeclare or reassign 
// using const. Const Creates block scope

What is the difference between let and const?

//You can reassign with let, but you can not redeclare or reassign using const

What is hoisting?

//It referes to the behavior where declarations of functions, variables, and classes
// are moved to the top of their containing scope during the compilation phase,
// before the code is executed. This means that variables and functions 
//can be referenced before their actual declaration in the code