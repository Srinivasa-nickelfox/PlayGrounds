import UIKit
import Darwin
import Foundation

struct Quote: Codable {
    var text: String
    var author: String?
}

/*
extension Quote {
    init?(dictionary: [String : String?]) {
        guard let text = dictionary["text"] as? String,
              let author = dictionary["author"] as? String else {
            return nil
        }
        self.text = text
        self.author = author
    }
}
*/

//"https://type.fit/api/quotes"

let url = URL(string: "https://type.fit/api/quotes")!

URLSession.shared.dataTask(with: url) { data, response, error in
    
   /* guard error == nil, let data = data else {
        print(error!)
        return
    }
    print(data)
   */
    
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

    //print(String(data: data!, encoding: .utf8)!)
    //let quotes = try JSONDecoder().decode(QouteSerialize.self, from: data)
    /*
    do {
        if let quotes = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: String?]] {
            let arrayOfQuotes = quotes.compactMap(Quote.init)
            print(arrayOfQuotes)
            print(".................................................................................................")
            print("Total \(arrayOfQuotes.count) quotes.")
            print(".................................................................................................")
            let quote = arrayOfQuotes.randomElement()
            print("\(quote?.text ?? "May God bless you!") - \(quote?.author ?? "Anonymous")")
        }
    } catch {
        print(error)
    }
}.resume()
     */
    
    do {
        let quotes = try JSONDecoder().decode([Quote].self, from: data)
        print(quotes)
        print(".................................................................................................")
        print("Total \(quotes.count) quotes.")
        print(".................................................................................................")
        let quote = quotes.randomElement()
        print("\(quote?.text ?? "May God bless you!") - \(quote?.author ?? "Anonymous")")
        print(".................................................................................................")
        var limit = 2
        var totalQuotes = 0
        var index = 0
        var currentQuotesList: [Quote] = Array()
        totalQuotes = quotes.count
        while index < limit {
            currentQuotesList.append(quotes[index])
            index = index + 1
            print(currentQuotesList)
        }
        
    } catch {
        print("Error", error)
    }
}.resume()
    
