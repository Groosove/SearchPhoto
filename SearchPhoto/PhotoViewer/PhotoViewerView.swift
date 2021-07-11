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
        let image = model.image
        image.translatesAutoresizingMaskIntoConstraints = false
        image.center = self.center
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
        
        NSLayoutConstraint.activate(infoViewButtonConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
        NSLayoutConstraint.activate(likeButtonConstraints)
    }
}
