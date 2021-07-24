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

    let descriptionLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(dismissButton)
    }
    
    private func makeConstraints() {
        let imageViewConstraints = [
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ]

        let descriptionLabelConstraints = [
            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor)
        ]

        let dismissButtonConstraints = [
            dismissButton.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor, constant: 10),
            dismissButton.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 10)
        ]
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(descriptionLabelConstraints)
        NSLayoutConstraint.activate(dismissButtonConstraints)
    }

    @objc private func dismissScreen() {
        let rootVC = MainTabBarController()
        rootVC.modalPresentationStyle = .fullScreen
        present(rootVC, animated: true, completion: nil)
    }
}
