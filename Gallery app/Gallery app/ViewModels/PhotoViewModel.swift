//
//  PhotoViewModel.swift
//  Gallery app
//
//  Created by Victoria Samsonova on 5.03.25.
//

import Foundation
import UIKit

class PhotoViewModel {
    private let coreDataManager = CoreDataManager.shared
    let photo: SinglePhotoModel
    private(set) var image: UIImage?
    var isFav: Bool = false

    init(photo: SinglePhotoModel) {
        self.photo = photo
        self.isFav = CoreDataManager.shared.isPhotoInFavorites(photoID: photo.id)
        loadImageFromCoreData()
    }

    private func loadImageFromCoreData() {
        if let imageData = coreDataManager.fetchImageData(for: photo.id) {
            self.image = UIImage(data: imageData)
        }
    }
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        if let image = self.image {
            completion(image)
        } else {
            guard let urlString = photo.urls?["thumb"] else {
                completion(nil)
                return
            }
            ImageLoader.shared.loadImage(from: urlString) { [weak self] image in
                self?.image = image
                completion(image)
            }
        }
    }
    
    func toggleFavorite(image: UIImage) -> Bool {
        if coreDataManager.toggleFavorite(photo: photo, image: image) {
            isFav = true
        } else {
            isFav = false
        }
        return isFav
    }
}

