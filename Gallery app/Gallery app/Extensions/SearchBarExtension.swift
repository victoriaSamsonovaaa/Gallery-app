//
//  SearchBarExtension.swift
//  Gallery app
//
//  Created by Victoria Samsonova on 3.03.25.
//

import Foundation
import UIKit

extension PhotosSearchingViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        print("Searching for: \(searchText)")

        dataFetcher.fetchImages(queryWord: searchText) { [weak self] searchResults in
            guard let fetchedPhotos = searchResults else { return }
            self?.photos = fetchedPhotos.results
            self?.collectionView.reloadData()
        }

        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        photos.removeAll()
        collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            photos.removeAll()
            collectionView.reloadData()
        }
    }
}

