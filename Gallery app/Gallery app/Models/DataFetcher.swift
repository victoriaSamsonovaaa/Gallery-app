//
//  DataFetcher.swift
//  Gallery app
//
//  Created by Victoria Samsonova on 3.03.25.
//

import Foundation

class DataFetcher {
    
    var networkService = NetworkService()
    
    func fetchImages(queryWord: String, page: Int, completion: @escaping (ResultsModel?, String?) -> Void) {
        networkService.mainRequest(queryWord: queryWord, page: page) { (data, error) in
            if let error = error {
                print("error fetching images: \(error.localizedDescription)")
                completion(nil, "Failed to load images. Check your internet connection")
                return
            }
            guard let decodedData = self.customDecode(type: ResultsModel.self, from: data) else {
                print("failed to decode response")
                completion(nil, "Smth went wrong. Please try again later.")
                return
            }
            completion(decodedData, nil)
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

