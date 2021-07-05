//
//  PhotosCollectionViewCell.swift
//  SearchPhoto
//
//  Created by Артур Лутфуллин on 05.07.2021.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
	static let identifier = "PhotosCollectionViewCellId"
	
	lazy var photoImageView: UIImageView = {
			let imageView = UIImageView()
			imageView.translatesAutoresizingMaskIntoConstraints = false
			imageView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
			imageView.contentMode = .scaleAspectFill
			return imageView
		}()
	
	init(image: UIImage, frame: CGRect) {
		super.init(frame: frame)
		photoImageView.image = image
	}
	
	private func addSubviews() {
		addSubview(photoImageView)
	}
	
	private func makeConstraints() {
		let photoImageViewConstaints = [
			photoImageView.topAnchor.constraint(equalTo: self.topAnchor),
			photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
		]
		
		NSLayoutConstraint.activate(photoImageViewConstaints)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
