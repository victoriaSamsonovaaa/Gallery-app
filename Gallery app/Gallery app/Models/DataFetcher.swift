//
//  DataFetcher.swift
//  Gallery app
//
//  Created by Victoria Samsonova on 3.03.25.
//

import Foundation

class DataFetcher {
    
    var networkServise = NetworkService()
    
    func fetchImages(queryWord: String, completion: @escaping (ResultsModel?) ->()) {
        networkServise.mainRequest(queryWord: queryWord) { (data, error) in
            if let error = error {
                print("error recieved requesting data \(error.localizedDescription)")
                completion(nil)
            }
            let decode = self.customDecode(type: ResultsModel.self, from: data)
            completion(decode)
        }
    }
    
    
    func customDecode<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("failed to decode due to missing key '\(key.stringValue)' – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("failed to decode due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("failed to decode due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("failed to decode because it appears to be invalid JSON.")
        } catch {
            fatalError("failed to decode: \(error.localizedDescription)")
        }
    }
}

