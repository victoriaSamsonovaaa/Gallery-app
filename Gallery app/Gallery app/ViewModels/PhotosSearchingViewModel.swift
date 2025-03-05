//
//  PhotosSearchingViewModel.swift
//  Gallery app
//
//  Created by Victoria Samsonova on 5.03.25.
//

import Foundation
import UIKit

class PhotosSearchingViewModel {
    
    private let dataFetcher = DataFetcher()
    var photos: [SinglePhotoModel] = []
    
    var onPhotosUpdated: (() -> Void)?
    
    func searchPhotos(query: String) {
        guard !query.isEmpty else { return }
        
        dataFetcher.fetchImages(queryWord: query) { [weak self] searchResults in
            guard let fetchedPhotos = searchResults else { return }
            self?.photos = fetchedPhotos.results
//            if let photos2 = self?.photos {
//                print(photos2)
//            }
            self?.onPhotosUpdated?()
        }
    }
    
    func clearPhotos() {
        photos.removeAll()
        onPhotosUpdated?()
    }
}
