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
    
    private let heart: UIImageView = {
        let image = UIImage(systemName: "heart.fill")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .systemRed
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        return imageView
    }()
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor(#colorLiteral(red: 0.9952972531, green: 0.8822068572, blue: 0.8323535323, alpha: 1))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var singlePhoto: SinglePhotoModel! {
        didSet {
            loadImage()
        }
    }
    
//    override var isSelected: Bool {
//        didSet {
//            updateSelectedImageView()
//        }
//    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
//    private func updateSelectedImageView() {
//        photoImageView.alpha = isSelected ? 0.6 : 1
//        heart.alpha = isSelected ? 1 : 0
//    }
    
    private func loadImage() {
        guard let singlePhoto = singlePhoto,
              let photoURLString = singlePhoto.urls["thumb"],
              let url = URL(string: photoURLString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.photoImageView.image = image
                }
            }
        }.resume()
    }
    
    private func setPhoto() {
        addSubview(photoImageView)
        photoImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }
    
    private func setHeart() {
        addSubview(heart)
        heart.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: -6).isActive = true
        heart.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: -6).isActive = true
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
