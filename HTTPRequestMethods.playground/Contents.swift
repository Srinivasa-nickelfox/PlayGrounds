import UIKit
import Foundation

var greeting = "Hello, playground"

//https://reqres.in/api
//https://reqres.in/api/users

func makeGetRequest() {

    struct Users: Codable {
        let data: Data
    }

    struct Data: Codable {
        let id: Int
        let email: String
        let firstName: String
        let lastName: String
        let avatar: String
        
        private enum CodingKeys: String, CodingKey {
            case id = "id"
            case email = "email"
            case firstName = "first_name"
            case lastName = "last_name"
            case avatar = "avatar"
        }
    }

    let url = URL(string: "https://reqres.in/api/users/2")!

    let session = URLSession.shared

    var request = URLRequest(url: url)
    request.httpMethod = "GET"

    let task = session.dataTask(with: request) { data, response, error
        in
        if let error = error {
            print("Error", error)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Not the right response!")
            return
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            print("Error, status code", httpResponse.statusCode)
            return
        }
        
        guard let data = data else {
            print("Bad data!")
            return
        }
        
        do {
            let users = try JSONDecoder().decode(Users.self, from: data)
            print(users)
        } catch {
            print("Error", error)
        }
        
    }
    task.resume()
    
}

//makeGetRequest()


func makePostRequest() {
    
    struct Body: Codable {
        let name: String
        let job: String
    }
    
    guard let url = URL(string: "https://reqres.in/api/users") else {
        return
    }
    
    var requestPost = URLRequest(url: url)
    // method, body, headers
    requestPost.httpMethod = "post"
    requestPost.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let body = Body(name: "Midhun", job: "iOS Developer")
    requestPost.httpBody = try? JSONEncoder().encode(body)
    
    URLSession.shared.dataTask(with: requestPost) { data, _, error in
        guard let data = data, error == nil else {
            return
        }
        
        do {
            let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            print("Success! \(response)")
        }
        catch {
            print(error)
        }
    }.resume()
    //Make a request
}

//makePostRequest()


func makePutRequest() {
        guard let url = URL(string: "https://reqres.in/api/users/2") else {
            return
        }
        
        struct UploadData: Codable {
            let name: String
            let job: String
        }
        
        // Add data to the model
        let uploadDataModel = UploadData(name: "Midhun Kasibhatla", job: "Software Developer")
        
        // Convert model to JSON data
        guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
            return
        }
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
    
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("Success! \(response)")
            }
            catch {
                print(error)
            }
            
        }.resume()
    }

//makePutRequest()

/*func makeDeleteRequest() {
        guard let url = URL(string: "https://reqres.in/api/users/2") else {
            return
        }
   
        struct UploadData: Codable {
           let name: String
           let job: String
       }
    
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
        URLSession.shared.dataTask(with: request) { _, response, error in
            guard let error == nil else {
                return
            }
            
            
            if let httpResponse = response as? HTTPURLResponse {
                print("\(httpResponse.statusCode)")
            } else {
                print(error!)
            }

            
        }.resume()
    }
*/
//makeDeleteRequest()

func makePostRequestForRegister() {
    
    struct Body: Codable {
        let email: String
        let password: String
    }
    
    guard let url = URL(string: "https://reqres.in/api/register") else {
        return
    }
    
    var requestPost = URLRequest(url: url)
    // method, body, headers
    requestPost.httpMethod = "post"
    requestPost.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let body = Body(email: "tracey.ramos@reqres.in", password: "piggyrya")
    requestPost.httpBody = try? JSONEncoder().encode(body)
    
    URLSession.shared.dataTask(with: requestPost) { data, _, error in
        guard let data = data, error == nil else {
            return
        }
        
        do {
            let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            print("Success! \(response)")
        }
        catch {
            print(error)
        }
    }.resume()
    //Make a request
}

//makePostRequestForRegister()

func makePostRequestForLogin()  {
    
    struct Body: Codable {
        let email: String
        let password: String
    }
    
    struct UserToken: Codable {
        let token: String
    }
    
    guard let url = URL(string: "https://reqres.in/api/login") else {
        return //"Bad API"
    }
    
    var requestPost = URLRequest(url: url)
    // method, body, headers
    requestPost.httpMethod = "post"
    requestPost.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let body = Body(email: "tracey.ramos@reqres.in", password: "piggyrya")
    requestPost.httpBody = try? JSONEncoder().encode(body)
    print(body)
    
    URLSession.shared.dataTask(with: requestPost) { data, response, error in
        if let error = error {
            print("Error", error)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Not the right response!")
            return
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            print("Error, status code", httpResponse.statusCode)
            return
        }
        
        guard let data = data else {
            print("Bad data!")
            return
        }
        print(data)
//        let x = try JSONDecoder().decode(UserToken.self, from: data)
//        print(x)
        
        do {
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Not the right response!")
                return
            }
            let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            print(httpResponse.statusCode)
            print("Success! \(response)")
            
        }
        catch {
            print(error)
        }
    }.resume()
    //Make a request
    //return userToken
}

//makePostRequestForLogin()













struct Login: Encodable {
    let email: String
    let password: String
}

struct UserToken: Codable {
    let token: String
}

struct User: Codable {
    let data: Data
}

struct Data: Codable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    let avatar: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case email = "email"
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "avatar"
    }
}


let baseUrl = "https://reqres.in/api"

class NetworkingService9 {
    
    func handleResponse(for request: URLRequest,
                        completion: @escaping (UserToken?, Error?) -> Void) -> Void {
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, _, error) -> Void in
            
            DispatchQueue.main.async {
                
                if let error = error {
                    print(error)
                    return
                }
                
                if let data = data {
                    
                    do {
                        let userToken = try JSONDecoder().decode(UserToken.self, from: data)
                            completion(userToken, nil)
                        
                    } catch {
                        print(error)
                    }
                }
            }
        }
        
        task.resume()
    }
    
   /* func request9(endpoint: String,
                 parameters: [String: Any],
                 completion: @escaping (UserToken?, Error?) -> Void) {
        
        guard let url = URL(string: baseUrl + endpoint) else {
            print(Error.self)
            return
        }
        
        var request = URLRequest(url: url)
        
        var components = URLComponents()
        
        var queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            
            let queryItem = URLQueryItem(name: key, value: String(describing: value))
            queryItems.append(queryItem)
        }
        
        components.queryItems = queryItems
        
        let queryItemData = components.query?.data(using: .utf8)
        
        request.httpBody = queryItemData
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        handleResponse(for: request, completion: completion)
    }*/
    
    func request(endpoint: String,
                 loginObject: Login,
                 completion: @escaping (UserToken?, Error?) -> Void ) -> Void  {
        
        guard let url = URL(string: baseUrl + endpoint) else {
            completion(nil, Error.self as? Error)
            return
        }
        
        var request = URLRequest(url: url)
        
        do {
            let loginData = try JSONEncoder().encode(loginObject)
            request.httpBody = loginData
                print(String(data: loginData, encoding: .utf8)!)

        } catch {
            completion(nil, error)
        }
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        handleResponse(for: request, completion: completion)
    }
    
}



let networkingService9 = NetworkingService9()

func loginRequest(email:String, password: String) -> Void {
    
    let login = Login(email: email, password: password)
    
    networkingService9.request(endpoint: "/login", loginObject: login) { userToken, error
        in
        if let error = error {
            print(error)
        } else {
            print(userToken!.token as String)
        }
    }
}

//loginRequest(email: "tracey.ramos@reqres.in", password: "piggyrya")
 

struct Body: Codable {
    let email: String
    let password: String
}

struct Token: Codable {
    let token: String
}

func fetchUser( loginObject: Body, userCompletionHandler: @escaping (Token?, Error?) -> Void) {
    
    let url = URL(string: "https://reqres.in/api/login")!
    
    //var request = URLRequest(url: url)
    var requestPost = URLRequest(url: url)
    // method, body, headers
    requestPost.httpMethod = "post"
    requestPost.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let body = loginObject//Body(email: "tracey.ramos@reqres.in", password: "piggyrya")
    requestPost.httpBody = try? JSONEncoder().encode(body)
    print(body)
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: requestPost) { (data, _, error) -> Void in
        
        DispatchQueue.main.async {
            
            if let error = error {
                print(error)
                return
            }
            
            if let data = data {
                
                do {
                    let userToken = try JSONDecoder().decode(Token.self, from: data)
                        userCompletionHandler(userToken, nil)
                    
                } catch {
                    print(error)
                    userCompletionHandler(nil, error)
                }
            }
        }
    }
    
    task.resume()
    
}

fetchUser(loginObject: Body(email: "janet.weaver@reqres.in", password: "piggyrya"), userCompletionHandler: { userToken, error in
    if let userToken = userToken {
        print(userToken.token)
    }
})








class makeGetRequestAgain {
    
    func handleResponse(for request: URLRequest,
                        completion: @escaping (User?, Error?) -> Void) {
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error
            in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error", error)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Not the right response!")
                    return
                }
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    print("Error, status code", httpResponse.statusCode)
                    return
                }
                
                guard let data = data else {
                    print("Bad data!")
                    return
                }
                
                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    print(user.data)
                } catch {
                    print("Error", error)
                }
            }
            
        }
        task.resume()
    }


func request(endpoint: String, loginObject: Login,
             completion: @escaping (User?, Error?) -> Void) {
    
    guard let url = URL(string: baseUrl + endpoint) else {
        completion(nil, Error.self as? Error)
        return
    }
    
    var request = URLRequest(url: url)
    
    do {
        let loginData = try JSONEncoder().encode(loginObject)
        request.httpBody = loginData

    } catch {
        completion(nil, error)
    }
    
    request.httpMethod = "GET"
    //request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    
    makeGetRequestAgain().handleResponse(for: request, completion: completion)
}
}

func userDataRequest(email:String, password: String) {
    let login = Login(email: email, password: password)
    let index = 2
    
    return makeGetRequestAgain().request(endpoint: "/users/\(index)" ,loginObject: login) {user, error in}

}

//userDataRequest(email: "rachel.howell@reqres.in", password: "panj")


    

