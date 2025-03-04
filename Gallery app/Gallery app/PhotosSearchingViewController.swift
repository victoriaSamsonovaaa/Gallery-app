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
        setCollectionViewLayout()
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.item]
        let detailViewController = PhotoDetailViewController()
        detailViewController.photo = photo
        navigationController?.pushViewController(detailViewController, animated: true)
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
    }
    
    private func creatingCollectionView() {
        collectionView.register(SinglePhotoCell.self, forCellWithReuseIdentifier: SinglePhotoCell.reuseId)
    }
    
    private func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let itemsPerRow: CGFloat = 2
        let paddingWidth = spacing * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingWidth
        let itemWidth = availableWidth / itemsPerRow
        
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.2) 
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        collectionView.collectionViewLayout = layout
    }
}
