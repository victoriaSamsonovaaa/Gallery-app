//
//  NetworkService.swift
//  Gallery app
//
//  Created by Victoria Samsonova on 3.03.25.
//

import Foundation

class NetworkService {
    func mainRequest(queryWord: String, completion: @escaping (Data?, Error?) -> Void) {
        let url = self.returnURL(queryWord: queryWord)
        var request = URLRequest(url: url)
        let myAPI = self.getAPI()
        request.setValue("Client-ID \(myAPI)", forHTTPHeaderField: "Authorization")
        //request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func returnURL(queryWord: String?) -> URL {
        var parametrs = [String: String]()
        parametrs["query"] = queryWord
        parametrs["page"] = String(1)
        parametrs["per_page"] = String(30)
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        components.queryItems = parametrs.map {
            URLQueryItem(name: $0, value: $1)
        }
        return components.url!
    }
    
    private func getAPI() -> String {
        print("aaaaa")
        guard let infoDictionary: [String: Any] = Bundle.main.infoDictionary else {
            print("didn't get a dictionary")
            return "didn't get a dictionary"
        }
        guard let myApiKey: String = infoDictionary["MyAPI"] as? String else {
            print("didn't get a key")
            return "didn't get a key"
        }
        print("Here's your api key value -> \(myApiKey)")
        return myApiKey
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
