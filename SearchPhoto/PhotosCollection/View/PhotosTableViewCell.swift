//
//  PhotosTableViewCell.swift
//  SearchPhoto
//
//  Created by Artur Lutfullin on 7/5/21.
//

import UIKit

extension PhotosTableViewCell {
    struct Appearance {
        let blurSize = CGSize(width: 32, height: 32)
    }
}

final class PhotosTableViewCell: UITableViewCell {
    static let identifier = "PhotosTableViewCellId"
    private let appearance = Appearance()
	private(set) var isLoading = false
	private let semaphore = DispatchSemaphore(value: 1)
	private(set) lazy var photoView: UIImageView = {
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

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(image: String, photograph: String, blurHash: String) {
        self.photoView.image = UIImage(blurHash: blurHash, size: appearance.blurSize)
        self.photoView.loadImage(imageURL: image)
		semaphore.wait()
        self.photographLabel.text = photograph
		semaphore.signal()
		isLoading = true
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
			photoView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
		]

		let photographLabelConstraints = [
			photographLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
			photographLabel.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor)
		]
		NSLayoutConstraint.activate(photographLabelConstraints)
		NSLayoutConstraint.activate(photoViewConstraints)
	}
}
