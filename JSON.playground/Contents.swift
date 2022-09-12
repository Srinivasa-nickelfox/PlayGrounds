import UIKit

var greeting = "Hello, playground"

//Using JSONSerialization to convert JSON into model objects.

struct CustomerSerialize {
    var firstName: String
    var lastName: String
    var age: Int
}

extension CustomerSerialize {
    init?(dictionary: [String: Any]) {
        guard let firstName = dictionary["firstName"] as? String,
              let lastName = dictionary["lastName"] as? String,
              let age = dictionary["age"] as? Int else {
              return nil
        }
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
}

//For a single Item
let json = """
{
    "firstName" : "Midhun",
    "lastName" : "Kasibhatla",
    "age" : 23
}
""".data(using: .utf8)!

print("JSONSerialization for single item")

if let dictionary = try! JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [String : Any] {
    if let customerSerialized = CustomerSerialize(dictionary: dictionary) {
        print(customerSerialized)
    }
}

//For an array of Items
let json2 = """
[
  {
    "firstName" : "Midhun",
    "lastName" : "Kasibhatla",
    "age" : 23
  },
  {
    "firstName" : "Krishna",
    "lastName" : "Pandey",
    "age" : 32
  },
  {
    "firstName" : "Rama",
    "lastName" : "Bharata",
    "age" : 36
  }
]
""".data(using: .utf8)!

print("JSONSerialization for an Array of item")


if let customerDictionaries = try! JSONSerialization.jsonObject(with: json2, options: .allowFragments) as? [[String : Any]] {

    /*
     let customers = customerDictionaries.compactMap { dictionary
        in
        return Customer(dictionary: dictionary)
    }
    */
    let customers = customerDictionaries.compactMap(CustomerSerialize.init)
     print(customers)
}

//Decoding JSON into a model
struct CustomerDecode: Decodable {
    var firstName: String
    var lastName: String
    var age: Int
    
    /*
     private enum CodingKeys : String, CodingKey {
        case firstName
        case lastName
        case age
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.age = try container.decode(Int.self, forKey: .age)
    }
    */
}

let customerDecoded = try JSONDecoder().decode(CustomerDecode.self, from: json)
print("Decoding JSON into model")
print(customerDecoded)

//Encoding model to JSON
  //Instead of Decodable or Encodable, we can use Codable protocol which is combination of both.
struct CustomerEncode: Codable {  //We can also write "Encodable"
    var firstName: String
    var lastName: String
    var age: Int
    
    /*
     private enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case age
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.firstName, forKey: .firstName)
        try container.encode(self.lastName, forKey: .lastName)
        try container.encode(self.age, forKey: .age)
     
     }
     */
}

let customerEncodable = CustomerEncode(firstName: "Midhun", lastName: "Kasibhatla", age: 23)
let encodedCustomerJSON = try JSONEncoder().encode(customerEncodable.self)
print("Encoding model to JSON")
print(encodedCustomerJSON)
print(String(data: encodedCustomerJSON, encoding: .utf8)!)

//Decoding JSON Array
struct Place: Decodable {
    var name: String
    var latitude: Double
    var longitude: Double
    var visited: Bool
}

let json3 = """
[
  {
  "name" : "Costa Rica",
  "latitude" : 23.45,
  "longitude" : 45.34,
  "visited" : true
  },
  {
  "name" : "Puerto Rico",
  "latitude" : 43.24,
  "longitude" : 17.42,
  "visited" : false
  },
  {
  "name" : "Mexico City",
  "latitude" : 12.67,
  "longitude" : 76.64,
  "visited" : false
  },
  {
  "name" : "Iceland",
  "latitude" : 91.56,
  "longitude" : 65.22,
  "visited" : true
  }
]
""".data(using: .utf8)!

let decodedPlaces = try JSONDecoder().decode([Place].self, from: json3)
print("Decoding JSON Array")
print(decodedPlaces)

//Decoding basic key-value types
struct PlacesResponse: Decodable {  //Using Response model to decode JSON
    var places: [TouristPlace]
}

struct TouristPlace: Decodable {
    var name: String
    var latitude: Double
    var longitude: Double
    var visited: Bool
}

let json4 = """
{
    "places" : [
                  {
                      "name" : "Costa Rica",
                      "latitude" : 34.56,
                      "longitude" : 64.67,
                      "visited" : true
                  },
                  {
                      "name" : "Mexico City",
                      "latitude" : 12.67,
                      "longitude" : 76.64,
                      "visited" : false
                  }
               ]
}
""".data(using: .utf8)!

//let placesDictionary = try JSONDecoder().decode([String: [TouristPlace]].self, from: json4)
//print(placesDictionary)
//let places = placesDictionary["places"]!
//print(places)
let placesResponse = try JSONDecoder().decode(PlacesResponse.self, from: json4)
print("Decoding basic key-value types")
print(placesResponse.places)

//Decoding a nested object
enum AddressType: String, Decodable {  //Decoding enum types
    case house = "house"
    case apartment = "apartment"
    case townHouse = "townHouse"
    case villa = "villa"
}

struct Geo: Decodable {
    var latitude: Double
    var longitude: Double
}

struct Address: Decodable {
    var street: String
    var city: String
    var state: String
    var geo: Geo
    var addressType: AddressType
}

struct Customer: Decodable {
    var firstName: String
    var lastName: String
    var address: Address
}

struct CustomerResponse: Decodable {
    var customers: [Customer]
}

let json5 = """
{
    "customers" : [
                    {
                       "firstName" : "John",
                       "lastName"  : "Doe",
                       "address"   :  {
                                          "street" : "1200 Richmond Ave",
                                          "city"   : "Houston",
                                          "state"  : "Texas",
                                          "geo"    : {
                                                         "latitude"  : 45.56,
                                                         "longitude" : 87.98
                                                     },
                                          "addressType" : "villa"
                                      }
                    }
                  ]
}
""".data(using: .utf8)!

let customerResponse = try JSONDecoder().decode(CustomerResponse.self, from: json5)
print("Decoding a nested object")
print(customerResponse)
print(customerResponse.customers[0].address.geo.longitude)
print(customerResponse.customers[0].address.addressType.rawValue)

//handling property name mismatches
struct Person: Codable {
    var firstName: String
    var lastName: String
    var age: Int
}

let json6 = """
{
   "first_name" : "Raghu",
   "last_name"  : "Veera",
   "age" : 25
}
""".data(using: .utf8)!

let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase
let person = try decoder.decode(Person.self, from: json6)
print(person)

//Mapping properties using CodingKeys

struct Address1: Codable {
    var street: String
    var state: String
    var zipcode: Int
    
    private enum CodingKeys: String, CodingKey {
        case street = "STREET"
        case state = "STATE"
        case zipcode = "ZIPCODE"
    }
}

struct Person2: Codable {
    var firstName: String
    var lastName: String
    var age: Int
    var address: Address1?
    
    private enum CodingKeys: String, CodingKey {
        case firstName = "FIRSTNAME"
        case lastName = "LASTNAME"
        case age = "AGE"
        case address = "ADDRESS"
    }
}

let json7 = """
{
   "FIRSTNAME" : "Raghu",
   "LASTNAME"  : "Veera",
   "AGE" : 25,
   "ADDRESS": {
                "STREET" : "1200 Richmond Ave",
                "STATE" : "TX",
                "ZIPCODE" : 77042
              }
}
""".data(using: .utf8)!

let person2 = try JSONDecoder().decode(Person2.self, from: json7)
print(person2)

//Decoding arbitrary types using type erasure methods
struct AnyDecodable: Decodable {
    let value: Any
    
    init<T>(_ value: T?) {
        self.value = value ?? ()
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let string = try? container.decode(String.self) {
            self.init(string)
        } else if let int = try? container.decode(Int.self) {
            self.init(int)
        } else {
            self.init(())
        }
    }
}

let json8 = """
{
    "foo" : "Hello",
    "bar" : 123,
    "zee" : true
}
""".data(using: .utf8)!

let dictionary = try JSONDecoder().decode([String: AnyDecodable].self, from: json8)
print(dictionary["foo"]?.value as Any)
print(dictionary["bar"]!.value)
print(dictionary["zee"]!.value)

//Decoding inherited types
//Decoding from different types of values
//Implementing custom encoding strategy

//Decoding JSON to flat model

//Consuming JSON Web API

//Custom Key decoding in Swift
