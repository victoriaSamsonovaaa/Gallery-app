//
//  FavouritesPhotosViewController.swift
//  Gallery app
//
//  Created by Victoria Samsonova on 3.03.25.
//

import Foundation
import UIKit

class FavouritesPhotosViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var viewModel = FavouritesPhotosViewModel()
    private var photosInRow: CGFloat = 2
    private let sectionInsets: CGFloat = 14
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateFavorites), name: NSNotification.Name("FavoritesUpdated"), object: nil)

        setCollectionViewLayout()
        creatingNavigationBar()
        creatingCollectionView()
        viewModel.loadFavorites()
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.refreshFavorites()
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.favPhotos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SinglePhotoCell.reuseId, for: indexPath) as? SinglePhotoCell else {
            return UICollectionViewCell()
        }
        let photo = viewModel.favPhotos[indexPath.item]
        let singlePhotoModel = SinglePhotoModel(id: photo.id!, width: Int(photo.width), height: Int(photo.height), urls: nil, description: photo.photoDescription)
        let photoViewModel = PhotoViewModel(photo: singlePhotoModel)
        photoViewModel.isFav = true
        cell.viewModel = photoViewModel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 10
        let totalSpacing = (photosInRow - 1) * spacing + sectionInsets * 2
        let availableWidth = view.frame.width - totalSpacing
        let widthPerItem = availableWidth / photosInRow
        let photo = viewModel.favPhotos[indexPath.item]
        let height = CGFloat(photo.height) * widthPerItem / CGFloat(photo.width)
        return CGSize(width: widthPerItem, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPhoto = viewModel.favPhotos[indexPath.item]
        let singlePhotoModel = SinglePhotoModel(id: selectedPhoto.id!, width: Int(selectedPhoto.width), height: Int(selectedPhoto.height), urls: nil, description: selectedPhoto.photoDescription)
        let detailViewController = PhotoDetailViewController()
        detailViewController.viewModel = PhotoViewModel(photo: singlePhotoModel)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    private func creatingNavigationBar() {
        let appTitle = UILabel()
        appTitle.text = "Favourites photos"
        appTitle.font = UIFont.systemFont(ofSize: 20, weight: .light)
        appTitle.textColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: appTitle)
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
        viewModel.refreshFavorites()
        collectionView.reloadData()
    }
}

