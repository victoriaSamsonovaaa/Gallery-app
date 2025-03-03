//
//  PhotosSearchingViewController.swift
//  Gallery app
//
//  Created by Victoria Samsonova on 3.03.25.
//

import Foundation
import UIKit

class PhotosSearchingViewController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        creatingNavigationBar()
        creatingSearchBar()
        creatingCollectionView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath)
        cell.backgroundColor = .cyan
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
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
        searchField.hidesNavigationBarDuringPresentation = false
        searchField.obscuresBackgroundDuringPresentation = false
    }
    
    private func creatingCollectionView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellId")
    }
}
