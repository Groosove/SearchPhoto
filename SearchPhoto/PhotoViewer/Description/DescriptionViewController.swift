//
//  DescriptionViewController.swift
//  SearchPhoto
//
//  Created by Артур Лутфуллин on 14.07.2021.
//

import UIKit

protocol DescriptionViewControllerDelegate: AnyObject {
	func dismissSelf()
}

class DescriptionViewController: UIViewController {
	lazy var descView = self.view as? DescriptionView
	let model: PhotoStatModel

	override func loadView() {
		super.loadView()
		self.view = DescriptionView(model: model)
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		descView?.delegate = self
		view.backgroundColor = .black
	}

	init(model: PhotoStatModel) {
		self.model = model
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension DescriptionViewController: DescriptionViewControllerDelegate {
	func dismissSelf() {
		dismiss(animated: true)
	}
}
