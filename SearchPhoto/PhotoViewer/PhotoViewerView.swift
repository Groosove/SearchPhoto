//
//  PhotoViewerView.swift
//  SearchPhoto
//
//  Created by Fenix Lavon on 7/11/21.
//

import UIKit


class PhotoViewerView: UIView {
    weak var delegate: PhotoViewerControllerDelegate?
    let model: PhotoViewerModel
    
    lazy var imagePresent: UIImageView = {
        let image = UIImageView()
        image.image = resizeImage(image: self.model.image.image!, targetSize: CGSize(width: self.model.width, height: self.model.height))
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var infoViewButton: UIButton = {
        let button = UIButton(type: .infoLight)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        return button
    }()

    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var downloadButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

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

    private func addSubviews() {
        addSubview(imagePresent)
        addSubview(infoViewButton)
        addSubview(likeButton)
        addSubview(downloadButton)
    }

    private func makeConstraints() {
        let infoViewButtonConstraints = [
            infoViewButton.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            infoViewButton.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
        ]
        
        let downloadButtonConstraints = [
            downloadButton.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            downloadButton.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
        ]
        
        let likeButtonConstraints = [
            likeButton.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            likeButton.bottomAnchor.constraint(equalTo: downloadButton.topAnchor),
        ]
        
        let imagePresentConstraints = [
            imagePresent.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imagePresent.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imagePresent.topAnchor.constraint(equalTo: self.topAnchor, constant: (UIScreen.main.bounds.height - model.height) / 2)
        ]
        
        NSLayoutConstraint.activate(infoViewButtonConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
        NSLayoutConstraint.activate(likeButtonConstraints)
        NSLayoutConstraint.activate(imagePresentConstraints)
    }
    
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        var newSize: CGSize
        
        if(widthRatio > heightRatio) {
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
