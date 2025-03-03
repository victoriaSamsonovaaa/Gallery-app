//
//  PrimaryTabBarController.swift
//  Gallery app
//
//  Created by Victoria Samsonova on 3.03.25.
//

import Foundation
import UIKit

class PrimaryTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tabBar.backgroundColor = .gray
        
        let galleryVC = PhotosSearchingViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let galleryNavigationVC = UINavigationController(rootViewController: galleryVC)
        galleryNavigationVC.tabBarItem = UITabBarItem(title: "Gallery", image: UIImage(systemName: "photo"), selectedImage: UIImage(systemName: "photo.fill"))
        
        let favouriteVC = FavouritesPhotosViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let favouriteNavigationVC = UINavigationController(rootViewController: favouriteVC)
        favouriteNavigationVC.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        
        viewControllers = [galleryNavigationVC, favouriteNavigationVC]
    }
}


