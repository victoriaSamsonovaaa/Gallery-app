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
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
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
        button.setImage(UIImage(systemName: "heart"), for: .normal)
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
        view.addSubview(imageView)
        view.addSubview(descriptionLabel)
        view.addSubview(likeButton)

        setLayout()
        bindViewModel()
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    private func bindViewModel() {
        descriptionLabel.text = viewModel.photo.description ?? "Seems that this photo doesn't have a description "

        viewModel.loadImage { [weak self] image in
            self?.imageView.image = image
        }
    }

    @objc private func likeButtonTapped() {
        guard let image = imageView.image else { return }
        viewModel.toggleFavorite(image: image)
    }
    
    private func setLayout() {
        let horizStackView = UIStackView(arrangedSubviews: [likeButton, likeDescription])
        horizStackView.axis = .horizontal
        horizStackView.spacing = 10
        horizStackView.alignment = .leading
        
        let stackView = UIStackView(arrangedSubviews: [imageView, horizStackView, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)
        
        let imageRatio = CGFloat(viewModel.photo.height) / CGFloat(viewModel.photo.width)
        let imageWidth = view.frame.width * 0.9
        let imageHeight = imageWidth * imageRatio
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            imageView.widthAnchor.constraint(equalToConstant: imageWidth),
            imageView.heightAnchor.constraint(equalToConstant: imageHeight),

            descriptionLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor),
        ])
    }
}
