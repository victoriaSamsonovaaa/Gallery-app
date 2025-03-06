//
//  DetailedPhotoViewModel.swift
//  Gallery app
//
//  Created by Victoria Samsonova on 6.03.25.
//

import Foundation
import UIKit

class DetailedPhotoViewModel {
    
    private let coreDataManager = CoreDataManager.shared
    var isFav: Bool = false
    var photo: SinglePhotoModel
    
    init(photo: SinglePhotoModel) {
        self.photo = photo
        checkIfFavorite()
    }
    
    func toggleFavorite(image: UIImage) -> Bool {
        if coreDataManager.toggleFavorite(photo: photo, image: image) {
            isFav.toggle()
        }
        return isFav
    }
    
    func checkIfFavorite() {
        isFav = coreDataManager.isPhotoInFavorites(photoID: photo.id)
    }
}
