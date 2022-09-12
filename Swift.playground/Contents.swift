import UIKit

var greeting = "Hello, playground"
print(greeting)

// Arrays, Sets and Dictionaries are called Collections
let m = "midhun"
let s = "srinivas"
let l = "lakshmi"
let v = "viveka"
let r = "rama"

// Array
let peopleArray : [String] = [m,s,l,v,r,s,m]
print(peopleArray[3])
// Set
let peopleSet = Set([m,s,l,v,m,r,s])
let peopleSet1 = Set([peopleArray])
print(peopleSet)
print(peopleSet1)
// Tuple
var tuple = (first: "Midhun", age: 23)
print(tuple.age)
print(tuple.first)
// Dictionary
let dictionary: [String : Double] = ["midhun" : 1.79, "sundar" : 1.54]
print(dictionary["midhun", default: 0])
print(dictionary["lakshmi", default: 0])

// Initializing empty collections
var teams = [String : Double]()

teams["midhun"] = 989

var teamsArray = [Int]()

var words = Set<String>()
var names = Array<String>()
var properties = Dictionary<String,Double>()

// Enumerations
enum result {
    case success
    case failure
}
let result2 = result.success
print(result2)

enum activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(pitch: Int)
}

let midhunTalking = activity.talking(topic: "Cricket")
print(midhunTalking)

// Enum Raw Values
enum planet: Int {
    case mercury = 1
    case venus
    case earth
    case mars
}

let myPlanet = planet(rawValue: 2)
print(myPlanet!)

//......................................................................

// Functions

class Functions {

    //Function with parameter
    func squareANumber (number : Int) {
       print( number * number )
    }

    //Function with parameter and return type
    func cuber(_ num : Int) -> Int{
       return num*num*num
    }

    //Function without parameter and return types
    func Coding(){
        print("Hi, do coding!")
    }

    // Default parameters to functions
    func greet(_ person: String, nicely: Bool = true){
        if nicely == true {
            print("Hello, \(person)!")
        } else {
            print("Oh no, it's \(person)! again...")
        }
    }

    // Variadic Functions
        //print("Midhun", "Viveka", "Rama")

    func squarer(num: Int...) {
        for i in num {
            print(i * i)
        }
    }

    // Throwing Functions
    enum passwordError : Error {
        case yes
    }

    func checkPassword(password : String) throws -> Bool {
        if password == "Password"{
            throw passwordError.yes
        }
        return true
    }

    //Running throwing functions
    func errorCatchFunction() {
        do{
        try checkPassword(password: "Password")
        print("Good Password!")
        } catch {
        print("Worst Password, use another!")
        }
    }

    //Variable parameters
    func doubleTheNum(number: inout Int) {
        print(2*number)
    }

    //Functions with multiple return values using tuples

    func findingMinMax(Array: [Int])->(minValue: Int, maxValue: Int){
        if Array.isEmpty {
            return (0,0)
        }
        var minValue = Array[0]
        var maxValue = Array[0]
        for i in 0 ..< Array.count {
            if Array[i] <= minValue {
                minValue = Array[i]
            }
            else if Array[i] > maxValue {
                    maxValue = Array[i]
            }
        }
        return (minValue, maxValue)
    }
}

let a = Functions()
var x = 20
a.squareANumber(number : 9)
print(a.cuber(9))
a.Coding()
a.greet("Laksman")
a.greet("Raju", nicely: false)
a.squarer(num: 1,2,3,4,5)
print(try a.checkPassword(password: "Madhu"))
a.errorCatchFunction()
a.doubleTheNum(number: &x)
print(a.findingMinMax(Array: [1,3,56,87,244,7414]))
print(a.findingMinMax(Array: []))

//.........................................................................

//Closures

//Basic Closure without parameter
let coding = {
    print("I'm learning closures!")
}
coding()
 
//Closures accepting parameters
let learning = {(language: String)
    in
    print("I'm learning \(language)!")
}
learning("Swift")

//Closures returning values
let myAge = {(age: Int) -> String
    in
    return "My age is \(age)."
}
print(myAge(23))

//Closures as Parameters
func closureIntoFunc(action: () -> Void) {
    print("Iam trying to pass a closure as parametr to a function.")
    action()
    print("Done!")
}
  //Calling function: closureIntoFunc
closureIntoFunc(action: coding)

//Trailing closure syntax
//Works when last parameter to a function is closure
func trailingClosure(work: () -> Void){
    work()
}
  //Calling function: trailingClosure
trailingClosure() {
    print("This is for trailing closure")
}
trailingClosure {
    print("Parentheses can be eliminated.")
}

//Using closures as parameters when they accept parameters
func travel(action: (String) -> Void){
    print("I'm getting ready to go,")
    action("Noida, Uttar Pradesh.")
}
  //Calling function: travel
travel { (destination: String) // -> Void
    in
    print("\(destination) on motor bike!")
}

//using closures as parameters when they return values
func love(action: (String) -> String){
    let x = action("iOS")
    print(x)
}
  //Calling function: love()
love { (interest : String) -> String
    in
    return "I love \(interest)!"
}

//Shorthand parameter names for closures
func age(action: (Int) -> String){
   let y = action(1998)
    print(y)
}
  //Calling function: age
age { (yob: Int) -> String
    in
    print("Pass your year of birth as parameter.")
    return "Your age is \(2022 - yob)."
}
  //As Swift knows the parameter that the closure in function: age taking is a Int, we can remove it
age { (yob) -> String
    in
    print("Removed parameter")
    return "Your age is \(2022 - yob)."
}
  //Similarly we can remove the return type of closure also as it is already mentioned in function definition
age { (yob)
    in
    print("Removed return type")
    return "Your age is \(2022 - yob)."
}
  //Also as the function knows it is returning something, we can remove it too
print("Remove return keyword from function call")
age { (yob)
    in
    "Your age is \(2022 - yob)."
}
  //Insted of "place in" we can use automatic names provided by swift for closures - "$number"
print("So, final form of shorthand parameter names:")
age {
    "Your age is \(2022 - $0)."
}

//Closures with multiple parameters
func postGraduation(action: (String, Int) -> String){
    let c = action("M.Tech", 2023)
    print(c)
}
postGraduation{
    return "I wanna pursue my \($0) in \($1)"
}

//Returning closures from functions
func play() -> (String) -> Void {
    return {
        print("I play \($0)!")
    }
}
play()("Footbal") // Not recommended
let d = play()
d("Cricket")

//Enclosing over/Capturing values
var count = 0
let e = {
    print(count)
    count += 1
}
e()
e()
e()

func play(action: () -> Void){
    action()
}
play {
    print(count)
    count += 1
}
play {
    print(count)
    count += 1
}

func cric() -> (String) -> Void {
    var start = 98
    
    return {
        print("\(start). I play \($0)!")
        start += 1
    }
}
let f = cric()
f("Cricket")
f("Football")
f("Hockey")

//Escaping closures, non-escaping closures, auto closures, completion handlers

//.........................................................................................

//Structs
  // You can create your own type using structures/structs
  //Creating our own struct
struct Sport {
    var name: String //Stored Properties
    var isOlympic: Bool
    
    var olympicStatus: String {   //Computed Property
        if isOlympic {
            return "Yes, \(name) is an OlympicSport."
        } else {
            return "No, \(name) is not an OlympicSport."
        }
    }
}

  //One can use stored properties or use computed properties to calclate values on fly

var mySport = Sport(name: "Tennis", isOlympic: true) //Instance of Struct
mySport.name = "Football"
print(mySport)

let cricket = Sport(name: "Cricket", isOlympic: false)
print(cricket.olympicStatus)

  //Property Observers
struct Progress {
    var task: String
    var amount: Int {
        didSet {  // Also "willSet" can  be used instead of 'didSet" to take action before a property changes
            print("\(task) is now \(amount)% completed")
        }
    }
}
var myProgress = Progress(task: "Loading data", amount: 0)
myProgress.amount = 10
myProgress.amount = 30
myProgress.amount = 75
 
  //Methods
  //Functions inside the Structs are called Methods
struct City {
    var population: Int
    
    func taxCollection() -> Int {
            return population * 1000
        }
}
var myCity = City(population: 5674) //Instance of Struct
print(myCity.taxCollection())

  //Mutating Methods
  //Swift wont let you write methods that change properties unless we specifically request it
  //If one wants to change a property inside a method, one must mark it as mutating
struct Person {
    var name: String
    
    mutating func printname() {
        name = "Seetha"
        print(name)
    }
}
var myPerson = Person(name: "Ramu")
myPerson.printname()

  //Properties and Methods of Strings
let myString = "I am Midhun!"
print(myString.count)  //"count" property for no. characters
print(myString.hasPrefix("I"))   //"hasPrefix" method checks whether string starts with specific letters
print(myString.uppercased())   //"uppercased" method convertes the string's letters to uppercase
print(myString.sorted())   //"sorted" method sorts the letters of String

  //Properties and methods of Arrays
  //Arrays are also structs which have their own methods and properties to query and manipulate them.
var animals = ["Pig"]
print(animals.count)   //"count" method counts no. of items in an array
animals.append("Dog")   //"append" method adds new items to array
animals.append("Cat")
print(animals)
print(animals.firstIndex(of: "Cat") ?? "No item with this name")
print(animals.firstIndex(of: "Elephant") ?? "No item with this name")   //"firstIndex" method locates an item inside the array
print(animals.sorted())   //"sorted" method sorts the items of Array
animals.remove(at: 2)   //"removeAt" method used to remove an item from the array at given index
print(animals)

  //Initializers
  //They are special methods that create structs. We get a memberwise initializer by default, but if you create your own you must give all properties a value
struct User {
    var username: String
     
    init() {
        username = "Midhun"
        print("Create your own user.")
    }
}

var myUser = User()
myUser.username = "Ram"
print(myUser)

   //Referring to current instance using self
struct Name {
    var name: String
    
    init(name: String) {  //here self.name refers to property and name refers to parameter
        print("\(name) is born here!")
        self.name = name
    }
}
print(Name.init(name: "Midhun"))

  //Lazy properties
  //This keyword tells swift to create properties only when they are first used
struct FamilyTree {
    init() {
        print("Creating family tree!")
    }
}

struct PersonAndFamily {
    var name: String
    lazy var familyTree = FamilyTree()
    
    init(name: String) {
        self.name = name
    }
}

var midhun = PersonAndFamily(name: "Kiran")
print(midhun)
midhun.familyTree
print(midhun.name)
print(midhun)

  //Static properties and methods
  //Swift can share specific properties and methods across all instances of the struct by declaring them static
struct Student {
    static var classSize = 0
    var name: String
    
    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
}

let ed = Student(name: "Ed")
let taylor = Student(name: "Taylor")
var kapil = Student(name: "Kapil")
print(Student.classSize)

  //Access control
  //Lets you restricts the properties and methods that a code can use.
struct Id {
    private var id: String   //Another common option is "public", which lets all other code use the property/method
    
    init(id: String) {
        self.id = id
    }
    
    func giveId() -> String {
        return id
    }
}

var myId = Id(id: "23408")
//print(myId.id) - here id is inaccessible due to private protection level
print(myId)

//.........................................................................................................................

//Classes and inheritance
  //Classes are similar to structs which allows to create new types with properties and methods but they have 5 important differences.
  //1.Classes never come with a memberwise initializer. This means one must always create own initializer for properties
class Dog {  //Parent class
    var name: String
    var breed: String
    
    func makeNoise() {
        print("Woof!")
    }
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

let poppy = Dog(name: "Poppy", breed: "Poodle")  //Instance of Dog class

  //2.Class inheritance
class Poodle: Dog {  //Child class or subclass
    override func makeNoise() {  //Overriding methods
        print("Yip!")
    }
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }
}

let poodle = Poodle(name: "Mark")
print(poodle.breed)
poodle.makeNoise()

  //Swift provides us "final" keyword to prevent the class to be inherited. None can override the methods in order to change behaviour if "final keyword added before class declaration
  
  //3.Copying objects
  //Difference between classes and structs is how they are copied.
var dog = Dog(name: "Jiggy", breed: "Hound")
print(dog.name)  //1st time

var dogCopy = dog
dogCopy.name = "Muggy"
print(dog.name)  //2nd time
  //Both dog and dogCopy point to the same object in memory.
  //But structs unlike classes, when we print dog.name 2nd time, it will give "Jiggy"
  
  //4.Deinitializers - Code that gets run when the instance of a class is destroyed.
class Man {
    var name: String
    
    init(name: String) {
        self.name = name
        print("Print \(name) is alive.")
    }
    
    func printGreeting() {
        print("Hello, I'm \(name)!")
    }
    
    deinit {   //This is called when Man instance is being destroyed.
        print("\(name) is no more!")
    }
}

for _ in 1...4 {
    let person = Man(name: "Midhun")
    person.printGreeting()
}

  //5.Mutability - This difference between classes and structs is the way they deal with constants.
  //A constant struct with variable property cannot be changed. Because of this struct need mutating keyword with methods that change properties. Classes doesn't require this mutating keyword.
class Singer {
    var name = "Latha"
}

let kishore = Singer()
kishore.name = "kumar"
print(kishore.name)
  //To stop this from happening in classes, we need to make the property constant --> let name = "Latha"

//.................................................................................................................

//Protocals
  //Protocals are a way of describing what properties and methods something must have.
protocol Reference {
    var id: String { get set}
}

struct Entity: Reference {
    var id: String
    
//    init(id: String) {
//        self.id = id
//    }
}

func displayID(thing: Reference) {
    print("My ID is \(thing.id)")
}

let myEntity = Entity.init(id: "Cosmic Particle")
print(myEntity.id)
displayID(thing: myEntity)

  //Protocal Inheritance
protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(days: Int)
}

protocol Employee: Payable, NeedsTraining, HasVacation { }

struct Employment : Employee {
    var name: String
    var experience: Int
    
    init(name: String, experience: Int) {
        self.name = name
        self.experience = experience
    }
    
    func calculateWages() -> Int {
        return experience*1000
    }
    
    func study() {
        print("Bachelor's Degree")
    }
    
    func takeVacation(days: Int) {
        print(days)
    }
    
    func probationPeriod() {
        print("First 3 months.")
    }
    
}

let myEmployment = Employment(name: "Midhun", experience: 4)
print(myEmployment.calculateWages())
myEmployment.study()
myEmployment.takeVacation(days: 12)
myEmployment.probationPeriod()

  //Extensions - allows to add methods to existing types.
extension Int {
    func squared() -> Int {
        return self * self
    }
}

extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}

let number = 9
print(number.squared())
print(number.isEven)


extension Employee {
    func promotionEligibility(experience: Int) -> Bool {
        if (experience > 4) {
            return true
        } else {
            return false
        }
    }
}
print(myEmployment.promotionEligibility(experience: 6))
print(myEmployment.experience.squared())

  //Protocol Extensions - helps to describe both methods something(Class, Struct, Enum) should have and also provide code inside.
let pythons = ["Eric", "Graham", "John", "Micheal", "Tommy", "Terry", "Terry"]   //Array
let beatles = Set(["John", "Paul", "George", "Ringo", "John"])  //Set
  //Swift's arrays and sets both conform to a protocol called "Collection".
extension Collection {
    func summarize() {
        print("There are \(count) of us:")
        
        for name in self {
            print(name)
        }
    }
}

pythons.summarize()
beatles.summarize()

  //Protocol Oriented Programming
protocol Identifiable {
    var id: String {get set}
    func identify()
}

extension Identifiable {
    func identify() {
        print("Not a cumpolsory method to conform.")
    }
}

struct Person1: Identifiable {
    var id: String
}

let myPerson1 = Person1(id: "Lakshman")
myPerson1.identify()

//Optionals - Swift's way of handling null references
  //Handling missing data
var age: Int? = nil
age = 23

  //Unwrapping optionals
var name: String? = nil
//Trying to read "name.count" is unsafe and swift won't allow it as name is optional.
if let unwrapped = name {  //Unwrapping with if-let
    print(unwrapped.count)
} else {
    print("Missing name.")
}

  //Unwrapping with guard
  //Alternative to if-let is guard-let
  //guard-let unwraps an optional but if it finds nil inside, it expects you yo exit the function, loop, or condition you used it in.
  //Major difference between if-let and guard-let is that your unwrapped optional remains usable after the guard code.
func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("Given nil value as parameter.")
        return
    }
    print("Hello, \(unwrapped)")
}  //guard-let solves the problem at the start of the function allowing the rest of the code unaffected.
greet(nil)

  //Force unwrapping - crash operator !
let str = "45"
let num = Int(str)
  //print(num) - prints Optional(45) because str may contain alphabets or symbols.
  //But as we are sure it is number inside, we can force unwrap.
let numUnwrapped = Int(str)!
print(numUnwrapped) //Here code will crash if str cannot be converted into Int.

  //Implicitly unwrapped optionals
  //Unlike regular optionals, Implicitly unwrapped optionals doesn't need to be unwrapped. They can be used as if they weren't optionals.
let age2: Int! = nil   //No need to use if-let and guard-let as they behave as already unwrapped.

  //Nil Coalescing
func username(for id: Int) -> String? {
    if id == 1 {
        return "Success"
    } else {
        return nil
    }
}
//print(username(for: 1)) -> this prints Optional("Success')
//print(username(for: 9)) -> this prints nil
  //Hence, nil coalescing operator provides a default value after unwrapping.
print(username(for: 1) ?? "Anonymous")
print(username(for: 9) ?? "Anonymous")

  //Optional Chaining
  //Swift provides a shortcut to access something like a.b.c and if b is optional, we can write it as a.b?.c
//print(peopleArray.first) -> Optional("midhun")
//print(peopleArray.first?.uppercased()) -> Optional("MIDHUN")
let emptyArray : [String] = ["midhun"]
let nothing = emptyArray.first?.uppercased()
print(nothing as Any)
print(nothing ?? "Nothing")
 
  //Optional try

  //Failable initializers

  //Typecasting
