//
//  SearchBarExtension.swift
//  Gallery app
//
//  Created by Victoria Samsonova on 3.03.25.
//

import Foundation
import UIKit

extension PhotosSearchingViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            self.dataFetcher.fetchImages(queryWord: searchText) { searchResults in
                searchResults?.results.map {
                    print($0.urls["thumb"])
            }
        }
        }
    }
}
