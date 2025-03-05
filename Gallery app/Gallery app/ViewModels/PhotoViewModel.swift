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

    init(photo: SinglePhotoModel) {
        self.photo = photo
    }

    func loadImage(completion: @escaping (UIImage?) -> Void) {
        guard let urlString = photo.urls?["thumb"] else {
            completion(nil)
            return
        }

        ImageLoader.shared.loadImage(from: urlString) { [weak self] image in
            self?.image = image
            completion(image)
        }
    }
    
    func toggleFavorite(image: UIImage) {
        coreDataManager.toggleFavorite(photo: photo, image: image)
    }
}

