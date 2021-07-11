//
//  PhotosTableViewCell.swift
//  SearchPhoto
//
//  Created by Fenix Lavon on 7/5/21.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    static let identifier = "PhotosTableViewCellId"
    
	lazy var photoView: UIImageView = {
		let image = UIImageView()
		image.contentMode = .scaleToFill
		image.translatesAutoresizingMaskIntoConstraints = false
		image.clipsToBounds = true
		return image
	}()
	
	private lazy var photographLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .white
		return label
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = .black
		addSubviews()
		makeConstraints()
	}
	
	private func addSubviews() {
		self.addSubview(photoView)
		photoView.addSubview(photographLabel)
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		photoView.image = nil
	}
	
	private func makeConstraints() {
		let photoViewConstraints = [
			photoView.topAnchor.constraint(equalTo: self.topAnchor),
			photoView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			photoView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			photoView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
		]

		let photographLabelConstraints = [
			photographLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
			photographLabel.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
		]
		
		NSLayoutConstraint.activate(photographLabelConstraints)
		NSLayoutConstraint.activate(photoViewConstraints)
	}
	
	func configure(image: String, photograph: String) {
		DispatchQueue.main.async {
			self.photoView.loadImage(imageURL: image)
            self.photographLabel.text = photograph
        }
    }
    
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
