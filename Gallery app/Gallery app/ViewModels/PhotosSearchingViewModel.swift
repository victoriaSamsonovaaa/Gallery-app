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
    private var currentPage = 1
    private var isLoading = false
    private var hasMorePages = true

    var onPhotosUpdated: (() -> Void)?
    var onError: ((String) -> Void)?

    func searchPhotos(query: String) {
        guard !query.isEmpty else {
            onError?("You can't leave searh field empty.")
            return
        }
        currentPage = 1
        photos.removeAll()
        fetchPhotos(query: query)
    }

    func loadMorePhotos(query: String) {
        guard hasMorePages, !isLoading else { return }
        currentPage += 1
        fetchPhotos(query: query)
    }

    private func fetchPhotos(query: String) {
        isLoading = true
        dataFetcher.fetchImages(queryWord: query, page: currentPage) { [weak self] searchResults, errorMessage in
            guard let self = self else { return }
            if let errorMessage = errorMessage {
                self.isLoading = false
                self.onError?(errorMessage)
                return
            }
            guard let fetchedPhotos = searchResults?.results, !fetchedPhotos.isEmpty else {
                self.isLoading = false
                self.hasMorePages = false
                self.onError?("No images found for \"\(query)\". Try a different search term")
                return
            }
            
            self.photos.append(contentsOf: fetchedPhotos)
            self.hasMorePages = fetchedPhotos.count > 0
            self.isLoading = false
            self.onPhotosUpdated?()
        }
    }

    func clearPhotos() {
        photos.removeAll()
        currentPage = 1
        hasMorePages = true
        DispatchQueue.main.async {
            self.onPhotosUpdated?()
        }
    }
}
