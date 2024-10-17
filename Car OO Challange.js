//Part ONE
class Vehicle {
    constructor(make, model, year) {
        this.make = make;
        this.model = model;
        this.year = year;
    }

    honk() {
        return "Beep Beep.";
    }

    toString () {
        return 'The vehicle is a ${this.year} ${this.make} ${this.model}.';
    }
}
// let myFirstVehicle = new Vehicle("Honda", "Monster Truck", 1999);
// console.log(myFirstVehicle.honk());
// console.log(myFirstVehicle.toString()); 

//Part TWO

class Car extends Vehicle {
    constructor(make, model, year) {
        super(make, model, year);// call the parent class constructor
        this.numWheels = 4; //set the number of wheels to 4
    }
}

//let myFirstCAr = new Car("Toyota", "Corolla", 2005);
// console.log(myFirstCar.toString()); 
// console.log(myFirstCar.honk());     

//Part THREE

class Motorcycle extends Vehicle {
    constructor(make, mode, year) {
        super(make, model, year);
        this.numWheels = 2;
    }

    revEngine() {
        return "VROOOOMM!!!";
    }
}

//let myFirstMotorcycle = new Motorcycle("Honda", "Nighthawk", 2000);
// console.log(myFirstMotorcycle.toString()); 
// console.log(myFirstMotorcycle.honk());     
// console.log(myFirstMotorcycle.revEngine());
// console.log(myFirstMotorcycle.numWheels);

class Garage {
    constructor(capacity) {
        this.vehicles = [];
        this.capacity = capacity;
    }

    add(vehicle) {
        if (!(vehicle instanceof Vehicle)) {
            return "Only vehicles are allowed in here!";
        }
        if (this.vehicle.length >= this.capacity) {
            return "Sorry, we are full!";
        }
        this.vehicles.push(vehicle);
        return "Vehicle added!";
    }
}

// let garage = new Garage(2);
// console.log(garage.vehicles); // []

// console.log(garage.add(new Car("Hyundai", "Elantra", 2015))); // "Vehicle added!"
// console.log(garage.vehicles); // [Car]

// console.log(garage.add("Taco")); // "Only vehicles are allowed in here!"

// console.log(garage.add(new Motorcycle("Honda", "Nighthawk", 2000))); // "Vehicle added!"
// console.log(garage.vehicles); // [Car, Motorcycle]

// console.log(garage.add(new Motorcycle("Honda", "Nighthawk", 2001))); // "Sorry, we're full."