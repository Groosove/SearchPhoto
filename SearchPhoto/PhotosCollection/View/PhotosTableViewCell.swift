//
//  PhotosTableViewCell.swift
//  SearchPhoto
//
//  Created by Fenix Lavon on 7/5/21.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    static let identifier = "PhotosTableViewCellId"
    
	private var image = UIImage()
	lazy var photoView: UIImageView = {
		let image = UIImageView()
		image.contentMode = .scaleAspectFill
		image.translatesAutoresizingMaskIntoConstraints = false
		image.clipsToBounds = true
		return image
	}()
	
	private lazy var photographLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
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
		addSubview(photographLabel)
	}

	private func makeConstraints() {
		let photoViewConstraints = [
			photoView.topAnchor.constraint(equalTo: self.topAnchor),
			photoView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
			photoView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
			photoView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
		]
		
		let photographLabelConstraints = [
			photographLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
			photographLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
			photographLabel.topAnchor.constraint(equalTo: self.topAnchor),
			photographLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
		]
		
		NSLayoutConstraint.activate(photographLabelConstraints)
		NSLayoutConstraint.activate(photoViewConstraints)
	}
	
	func configure(image: UIImage, photograph: String) {
		DispatchQueue.main.async {
			self.photoView.image = image
		}
		photographLabel.text = photograph
    }
	

	
	override func prepareForReuse() {
		super.prepareForReuse()
//		photoView.image = nil
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
