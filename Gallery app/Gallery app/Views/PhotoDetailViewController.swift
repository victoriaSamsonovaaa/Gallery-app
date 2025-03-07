//
//  PhotoDetailViewController.swift
//  Gallery app
//
//  Created by Victoria Samsonova on 3.03.25.
//

import Foundation
import SwiftData
import UIKit

class PhotoDetailViewController:UIViewController {
    
    var viewModel: PhotoViewModel!
    var photos: [SinglePhotoModel] = []
    var currentIndex: Int = 0
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let scrollStackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
      //  imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let likeDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .red
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Like this photo"
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setLayout()
        setupGestures()
        bindViewModel()
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    private func bindViewModel() {
        descriptionLabel.text = viewModel.photo.description ?? "Seems that this photo doesn't have a description"
        viewModel.loadImage { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
        updateLikeButton()
        updateLikeLabel()
    }
    
    @objc private func likeButtonTapped() {
        guard let image = imageView.image else { return }
        viewModel.isFav = viewModel.toggleFavorite(image: image)
        NotificationCenter.default.post(name: NSNotification.Name("FavoritesUpdated"), object: nil)
        updateLikeButton()
        updateLikeLabel()
        if !viewModel.isFav {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if let navController = self.navigationController {
                    if let favVC = navController.viewControllers.first(where: { $0 is FavouritesPhotosViewController }) as? FavouritesPhotosViewController {
                        favVC.viewModel.refreshFavorites()
                        favVC.collectionView.reloadData()
                    }
                }
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    private func updateLikeLabel() {
        likeDescription.textColor = viewModel.isFav ? .red : .lightGray
    }

    private func updateLikeButton() {
        let imageName = viewModel.isFav ? "heart.fill" : "heart"
        likeButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    private func setupGestures() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
    }
    
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            navigateToNext()
        } else if gesture.direction == .right {
            navigateToPrevious()
        }
    }
    
    private func navigateToPrevious() {
        guard currentIndex > 0 else { return }
        currentIndex -= 1
        viewModel = PhotoViewModel(photo: photos[currentIndex])
        bindViewModel()
    }
    
    private func navigateToNext() {
        guard currentIndex < photos.count - 1 else { return }
        currentIndex += 1
        viewModel = PhotoViewModel(photo: photos[currentIndex])
        bindViewModel()
    }

    
    private func setLayout() {
        let horizStackView = UIStackView(arrangedSubviews: [likeButton, likeDescription])
        horizStackView.axis = .horizontal
        horizStackView.spacing = 10
        horizStackView.alignment = .leading
        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollStackViewContainer)
        scrollStackViewContainer.addArrangedSubview(imageView)
        scrollStackViewContainer.addArrangedSubview(descriptionLabel)
        let spacer = UIView()
        spacer.heightAnchor.constraint(equalToConstant: 14).isActive = true
        scrollStackViewContainer.addArrangedSubview(spacer)
        scrollStackViewContainer.addArrangedSubview(horizStackView)
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            scrollStackViewContainer.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
            scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),
            scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -20),
            scrollStackViewContainer.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -40),

            imageView.widthAnchor.constraint(equalTo: scrollStackViewContainer.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: CGFloat(viewModel.photo.height) / CGFloat(viewModel.photo.width)),

            horizStackView.leadingAnchor.constraint(equalTo: scrollStackViewContainer.leadingAnchor),
            horizStackView.trailingAnchor.constraint(lessThanOrEqualTo: scrollStackViewContainer.trailingAnchor),
          //  horizStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),

            likeButton.widthAnchor.constraint(equalToConstant: 24),
            likeButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}
