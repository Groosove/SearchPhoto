//
//  HomeScreenController.swift
//  SearchPhoto
//
//  Created by Artur Lutfullin on 7/24/21.
//

import UIKit

final class HomeScreenController: UIViewController {
	//MARK: - Properties
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
	
	//MARK: - Init
	init(image: UIImage) {
		self.imageView.image = image
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	//MARK: - View Cycle
	override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        if isLast {
            dismissButton.isHidden = false
        }
        makeConstraints()
    }
    
	//MARK: - Setup UI
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

	//MARK: - Private functions
    @objc private func dismissScreen() {
        let rootVC = MainTabBarController()
        rootVC.modalPresentationStyle = .fullScreen
        present(rootVC, animated: true, completion: nil)
    }
}
