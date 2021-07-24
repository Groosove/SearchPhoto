//
//  FavoriteViewCell.swift
//  SearchPhoto
//
//  Created by Fenix Lavon on 7/20/21.
//

import UIKit

class FavoriteViewCell: UICollectionViewCell {
    static let identifier = "FavoriteViewCellId"

    private lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.borderWidth = 1
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image: UIImage?) {
        self.imageView.image = cropImage(image: image!, targetSize: CGSize(width: self.frame.width, height: self.frame.height))
    }

    private func makeConstraints() {
        let imageViewConstraints = [
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]

        NSLayoutConstraint.activate(imageViewConstraints)
    }
    
    private func cropImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        guard let cgImage = image.cgImage else { return nil }
        let contextImage: UIImage = UIImage(cgImage: cgImage)
        let contextSize: CGSize = contextImage.size
        var rect = CGRect.zero

        if contextSize.width > contextSize.height {
            rect = CGRect(x: ((contextSize.width - contextSize.height) / 2), y: 0, width: contextSize.height, height: contextSize.height)
        } else {
            rect = CGRect(x: 0, y: ((contextSize.height - contextSize.width) / 2), width: contextSize.width, height: contextSize.width)
        }

        guard let imageRef = cgImage.cropping(to: rect) else { return nil }
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        return image
    }

}
