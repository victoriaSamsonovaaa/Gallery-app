//
//  FavouritesPhotosViewModel.swift
//  Gallery app
//
//  Created by Victoria Samsonova on 6.03.25.
//

import Foundation
import UIKit

class FavouritesPhotosViewModel {
    private let coreDataManager = CoreDataManager.shared
    var favPhotos: [Photo] = []
    var isFav: Bool = false

    init() {
        loadFavorites()
    }

    func loadFavorites() {
        favPhotos = coreDataManager.fetchFavorites()
    }

    func refreshFavorites() {
        loadFavorites()
    }
    
}
