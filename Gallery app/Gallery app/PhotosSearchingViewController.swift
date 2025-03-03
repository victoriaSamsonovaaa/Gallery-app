//
//  PhotosSearchingViewController.swift
//  Gallery app
//
//  Created by Victoria Samsonova on 3.03.25.
//

import Foundation
import UIKit

class PhotosSearchingViewController: UICollectionViewController {
    
    var dataFetcher = DataFetcher()
    var timer = Timer()
    
    var photos = [SinglePhotoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creatingNavigationBar()
        creatingSearchBar()
        creatingCollectionView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SinglePhotoCell.reuseId, for: indexPath) as? SinglePhotoCell else {
            return UICollectionViewCell()
        }
        cell.singlePhoto = photos[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    private func creatingNavigationBar() {
        let appTitle = UILabel()
        appTitle.text = "Gallery App"
        appTitle.font = UIFont.systemFont(ofSize: 20, weight: .light)
        appTitle.textColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: appTitle)
    }
    
    private func creatingSearchBar() {
        let searchField = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchField
        navigationItem.hidesSearchBarWhenScrolling = false
        searchField.hidesNavigationBarDuringPresentation = false
        searchField.obscuresBackgroundDuringPresentation = false
        searchField.searchBar.delegate = self
        searchField.searchBar.showsSearchResultsButton = true
    }
    
    private func creatingCollectionView() {
        collectionView.register(SinglePhotoCell.self, forCellWithReuseIdentifier: SinglePhotoCell.reuseId)
    }
}
