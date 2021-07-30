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

final class DescriptionViewController: UIViewController {
    // MARK: - Properties
	private lazy var descView = self.view as? DescriptionView
	private let model: PhotoStatModel

    // MARK: - View cycle
	override func loadView() {
		super.loadView()
		self.view = DescriptionView(model: model)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		descView?.delegate = self
		view.backgroundColor = .black
	}

    // MARK: - Init
	init(model: PhotoStatModel) {
		self.model = model
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - DescriptionViewControllerDelegate
extension DescriptionViewController: DescriptionViewControllerDelegate {
	func dismissSelf() {
		dismiss(animated: true)
	}
}
