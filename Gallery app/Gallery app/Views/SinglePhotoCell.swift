//
//  SinglePhotoCell.swift
//  Gallery app
//
//  Created by Victoria Samsonova on 3.03.25.
//

import Foundation
import UIKit

class SinglePhotoCell: UICollectionViewCell {
    
    static let reuseId = "singlePhotoCell"
    private var isFav: Bool = false
    
    var viewModel: PhotoViewModel! {
        didSet {
            photoImageView.image = nil
            bindViewModel()
        }
    }
    
    private let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor(#colorLiteral(red: 0.9952972531, green: 0.8822068572, blue: 0.8323535323, alpha: 1))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()


    
    var photo: SinglePhotoModel!
    
    var delegate: PhotosSearchingViewModel?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    private func bindViewModel() {
        viewModel.loadImage { [weak self] image in
            DispatchQueue.main.async {
                self?.photoImageView.image = image
            }
        }
        isFav = viewModel.isFav
        updateLikeButton()
    }
    
    private func setPhoto() {
        addSubview(photoImageView)
        photoImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }
    
    private func setHeart() {
        addSubview(likeButton)
        NSLayoutConstraint.activate([
            likeButton.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: -8),
            likeButton.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: -8),
            likeButton.widthAnchor.constraint(equalToConstant: 30),
            likeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    private func updateLikeButton() {
        let imageName = isFav ? "heart.fill" : "heart"
        likeButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    @objc private func likeButtonTapped() {
        guard let image = photoImageView.image else { return }
        isFav = viewModel.toggleFavorite(image: image)
        updateLikeButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setPhoto()
        setHeart()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
