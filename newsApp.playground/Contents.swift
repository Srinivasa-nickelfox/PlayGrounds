import UIKit

var greeting = "Hello, playground"

struct ArticleResponse: Codable {
    var articles: [Article]
}

struct Article: Codable {
    var author: String?
    var title: String?
    var description: String?
    var url: URL?
    var urlToImage: URL?
    var content: String?
}
    
enum NetworkError: Error {
    case badResponse
    case badStatusCode(Int)
    case badData
}
   
class Networker {
    func getNews(completion: @escaping (ArticleResponse?, Error?) -> Void) {
        if let headLinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=in&apiKey=e7855adfcfbb4dd69e3fd27172d1aa4e") {
                    URLSession.shared.dataTask(with: headLinesURL) { data, response, error in
                        
                        if let error = error {
                            print("Error,\(error)")
                            DispatchQueue.main.async {
                                completion(nil, error)
                            }
                            return
                        }
                        
                        guard let httpResponse = response as? HTTPURLResponse else {
                            print("Not the right response!")
                            DispatchQueue.main.async {
                                completion(nil, NetworkError.badResponse)
                            }
                            return
                        }
                        
                        guard (200...299).contains(httpResponse.statusCode) else {
                            print("Error, status code", httpResponse.statusCode)
                            DispatchQueue.main.async {
                                completion(nil, NetworkError.badStatusCode(httpResponse.statusCode))
                            }
                            return
                        }
                        
                        guard let data = data else {
                            print("Bad data!")
                            DispatchQueue.main.async {
                                completion(nil, NetworkError.badResponse)
                            }
                            return
                        }

                        do {
                            let result = try JSONDecoder().decode(ArticleResponse.self, from: data)
                            //print(result.articles)
                            DispatchQueue.main.async {
                               completion(result, nil)
                            }
                        } catch {
                            print("Error", error)
                        }
                    }.resume()
        }

    }
    
    func search(query: String, completion: @escaping(ArticleResponse?, Error?) -> Void) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        let searchUrlString = "https://newsapi.org/v2/everything?sortBy=popularity&apiKey=af636d01048d448180b9daf62d844f43&q="
        let urlString = searchUrlString + query
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
                        
                        if let error = error {
                            print("Error,\(error)")
                            DispatchQueue.main.async {
                                completion(nil, error)
                            }
                            return
                        }
                        
                        guard let httpResponse = response as? HTTPURLResponse else {
                            print("Not the right response!")
                            DispatchQueue.main.async {
                                completion(nil, NetworkError.badResponse)
                            }
                            return
                        }
                        
                        guard (200...299).contains(httpResponse.statusCode) else {
                            print("Error, status code", httpResponse.statusCode)
                            DispatchQueue.main.async {
                                completion(nil, NetworkError.badStatusCode(httpResponse.statusCode))
                            }
                            return
                        }
                        
                        guard let data = data else {
                            print("Bad data!")
                            DispatchQueue.main.async {
                                completion(nil, NetworkError.badResponse)
                            }
                            return
                        }

                        do {
                            let resultNews = try JSONDecoder().decode(ArticleResponse.self, from: data)
                            //print(resultNews.articles)
                            //print(resultNews.articles.count)
                            //print("jhgchgch")
                            print(url)
                            DispatchQueue.main.async {
                               completion(resultNews, nil)
                            }
                        } catch {
                            print("Error", error)
                        }
                    }.resume()
    }
}


 extension URL {
    
    func appending(_ queryItem: String, value: String) -> URL {
        
        guard var urlComponents = URLComponents(string: absoluteString) else {return absoluteURL}
        
        var queryItems: [URLQueryItem] = urlComponents.queryItems ?? []
        
        var queryItem = URLQueryItem(name: queryItem, value: value)
        
        queryItems.append(queryItem)
        
        urlComponents.queryItems = queryItems
        
        return urlComponents.url!
    }
}



let networker = Networker()

    networker.getNews {(result, error) -> Void
    in
    if let error = error {
        print(error)
    } else if let result = result {
        print(result.articles.count)
    }
        
    }

let apiKey = "e7855adfcfbb4dd69e3fd27172d1aa4e"
var url = URL(string: "https://newsapi.org/v2/everything")
let queryURL = url?.appending("apiKey", value: apiKey).appending("q", value: "apple")
print(queryURL!.path)

var url1 = URL(string: "https://newsapi.org/v2/")
print(url?.path)

/*
 networker.search(query: "apple") {(result, error) -> Void
    in
    if let error = error {
        print(error)
    } else if let result = result {
        print("search Result")
        //print(result)
    }
}
*/

if let headLinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=in&apiKey=e7855adfcfbb4dd69e3fd27172d1aa4e") {
            URLSession.shared.dataTask(with: headLinesURL) { data, response, error
                in
                if let error = error {
                    print("Error,\(error)")
                    
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
                    let resultNews = try JSONDecoder().decode(ArticleResponse.self, from: data)
                    print(resultNews.articles.count)
                    print(resultNews)
                    print(resultNews.articles)
                    
                } catch {
                    print("Error", error)
                }
            }.resume()
}


