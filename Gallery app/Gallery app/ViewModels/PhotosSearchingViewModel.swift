//
//  PhotosSearchingViewModel.swift
//  Gallery app
//
//  Created by Victoria Samsonova on 5.03.25.
//

import Foundation
import UIKit
import CoreData

class PhotosSearchingViewModel {
    
    private let dataFetcher = DataFetcher()
    private let coreDataManager = CoreDataManager.shared
    var photos: [SinglePhotoModel] = []
    var isFav: Bool = false
    
    var onPhotosUpdated: (() -> Void)?
    
    func searchPhotos(query: String) {
        guard !query.isEmpty else { return }
        
        dataFetcher.fetchImages(queryWord: query) { [weak self] searchResults in
            guard let fetchedPhotos = searchResults else { return }
            self?.photos = fetchedPhotos.results
            self?.onPhotosUpdated?()
        }
    }
    
    func toggleFavorite(photo: SinglePhotoModel, image: UIImage) -> Bool {
        
        if coreDataManager.toggleFavorite(photo: photo, image: image) {
            isFav = true
        } else {
            isFav = false
        }
        return isFav
    }
    
    func clearPhotos() {
        photos.removeAll()
        onPhotosUpdated?()
    }

}
