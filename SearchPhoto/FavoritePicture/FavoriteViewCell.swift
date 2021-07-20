//
//  FavoriteViewCell.swift
//  SearchPhoto
//
//  Created by Fenix Lavon on 7/20/21.
//

import UIKit

class FavoriteViewCell: UICollectionViewCell {
    static let identifier = "FavoriteViewCellId"
    
    lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
    
    private func makeConstraints() {
        let imageViewConstraints = [
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(imageViewConstraints)
    }
    
    func configure(image: UIImage?) {
        self.imageView.image = image
    }
}
