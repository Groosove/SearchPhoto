//
//  HomeScreenController.swift
//  SearchPhoto
//
//  Created by Fenix Lavon on 7/24/21.
//

import UIKit

final class HomeScreenController: UIViewController {
    var isLast = false
    let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(dismissScreen), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
	init(image: UIImage) {
		self.imageView.image = image
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        if isLast {
            dismissButton.isHidden = false
        }
        makeConstraints()
    }
    
    private func addSubviews() {
        self.view.addSubview(imageView)
        self.view.addSubview(dismissButton)
    }
    
    private func makeConstraints() {
        let imageViewConstraints = [
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ]

        let dismissButtonConstraints = [
            dismissButton.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor, constant: 10),
            dismissButton.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 10)
        ]
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(dismissButtonConstraints)
    }

    @objc private func dismissScreen() {
        let rootVC = MainTabBarController()
        rootVC.modalPresentationStyle = .fullScreen
        present(rootVC, animated: true, completion: nil)
    }
}
