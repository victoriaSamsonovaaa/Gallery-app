//
//  PhotosSearchingViewController.swift
//  Gallery app
//
//  Created by Victoria Samsonova on 3.03.25.
//

import Foundation
import UIKit

class PhotosSearchingViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var viewModel = PhotosSearchingViewModel()
    private var photosInRow: CGFloat = 2
    private let sectionInsets: CGFloat = 14
    private var isLoadingMorePhotos = false
    var currentSearchQuery: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creatingNavigationBar()
        creatingSearchBar()
        setCollectionViewLayout()
        creatingCollectionView()
        NotificationCenter.default.addObserver(self, selector: #selector(updateFavorites), name: NSNotification.Name("FavoritesUpdated"), object: nil)
        viewModel.onPhotosUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.isLoadingMorePhotos = false
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SinglePhotoCell.reuseId, for: indexPath) as? SinglePhotoCell else {
            return UICollectionViewCell()
        }
        let photo = viewModel.photos[indexPath.item]
        let photoViewModel = PhotoViewModel(photo: photo)
        cell.viewModel = photoViewModel
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = PhotoDetailViewController()
        detailViewController.viewModel = PhotoViewModel(photo: viewModel.photos[indexPath.item])
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 10
        let totalSpacing = (photosInRow - 1) * spacing + sectionInsets * 2
        let availableWidth = view.frame.width - totalSpacing
        let widthPerItem = availableWidth / photosInRow
        let photo = viewModel.photos[indexPath.item]
        let height = CGFloat(photo.height) * widthPerItem / CGFloat(photo.width)
        return CGSize(width: widthPerItem, height: height)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.size.height, !isLoadingMorePhotos, let query = currentSearchQuery {
            isLoadingMorePhotos = true
            viewModel.loadMorePhotos(query: query)
        }
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
        collectionView.layoutMargins = UIEdgeInsets(top: 2, left: 14, bottom: 2, right: 14)
        collectionView.contentInsetAdjustmentBehavior = .automatic
    }
    
    private func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
    }
    
    @objc private func updateFavorites() {
        collectionView.reloadData()  
    }

}
