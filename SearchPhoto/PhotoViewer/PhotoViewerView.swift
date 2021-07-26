//
//  PhotoViewerView.swift
//  SearchPhoto
//
//  Created by Artur Lutfullin on 14.07.21.
//

import UIKit

final class PhotoViewerView: UIView {
	// MARK: - Properties
    weak var delegate: PhotoViewerControllerDelegate?
    private let model: PhotoViewerModel
	lazy var scrollView: ImageScrollView = {
		let image = resizeImage(image: self.model.image.image!, targetSize: CGSize(width: self.model.width, height: self.model.height))
		let scrollView = ImageScrollView(image: image!)
		scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 2.0
		return scrollView
	}()
    private lazy var infoViewButton: UIButton = {
        let button = UIButton(type: .infoLight)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.addTarget(delegate, action: #selector(infoButtonTapped), for: .touchUpInside)
        return button
    }()
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.addTarget(delegate, action: #selector(likeTapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var downloadButton: UIButton = {
       let button = UIButton()
        button.setImage( UIImage(named: "arrow"), for: .normal)
        button.addTarget(delegate, action: #selector(downloadTapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

	//MARK: - Init
    init(model: PhotoViewerModel) {
        self.model = model
        super.init(frame: UIScreen.main.bounds)
        addSubviews()
        makeConstraints()
        backgroundColor = .black
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	//MARK: - Setup UI
    private func addSubviews() {
		addSubview(scrollView)
        addSubview(infoViewButton)
        addSubview(likeButton)
        addSubview(downloadButton)
    }

    private func makeConstraints() {
        let infoViewButtonConstraints = [
            infoViewButton.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            infoViewButton.topAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ]

        let downloadButtonConstraints = [
            downloadButton.centerYAnchor.constraint(equalTo: infoViewButton.centerYAnchor),
            downloadButton.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor)
        ]

        let likeButtonConstraints = [
            likeButton.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            likeButton.bottomAnchor.constraint(equalTo: downloadButton.topAnchor, constant: -5)
        ]
		
		let scrollViewConstraints = [
			scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: (UIScreen.main.bounds.height - model.height) / 2),
			scrollView.heightAnchor.constraint(equalToConstant: scrollView.imageView.image!.size.height),
		]

        NSLayoutConstraint.activate(infoViewButtonConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
        NSLayoutConstraint.activate(likeButtonConstraints)
		NSLayoutConstraint.activate(scrollViewConstraints)
    }

	//MARK: - Update View functions
    @objc private func downloadTapButton(_ sender: AnyObject) {
		delegate?.downloadPhoto(with: scrollView.imageView.image!)
    }

    @objc private func likeTapButton(_ sender: AnyObject) {
        let image = getImage()
        likeButton.setImage(image.0, for: .normal)
        if image.1 == false {
            delegate?.savePhoto(with: model.image.image!, model: model)
        } else {
            delegate?.unsavePhoto(uid: model.uid)
        }
        updateConstraints()
    }

    @objc private func infoButtonTapped(_ sender: AnyObject) {
        delegate?.parsePhoto(with: model.uid)
    }
	
	//MARK: - Private functions
    private func getImage() -> (UIImage?, Bool) {
        let like = (delegate?.getImage(with: model.uid))!
        let image = (like) ? UIImage(named: "unlike") : UIImage(named: "like")
        return (image, like)
    }

    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        var newSize: CGSize

        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        let rect = CGRect(origin: .zero, size: newSize)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
