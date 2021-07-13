//
//  DescriptionViewController.swift
//  SearchPhoto
//
//  Created by Артур Лутфуллин on 14.07.2021.
//

import UIKit

class DescriptionViewController: UIViewController {
	
	let model: PhotoStatModel
	
	override func loadView() {
		self.view = DescriptionView(model: model)
		super.loadView()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .black
		addDismissButton()
	}
	
	init(model: PhotoStatModel) {
		self.model = model
		super.init(nibName: nil, bundle: nil)
	}
	

	
	private func addDismissButton() {
		let button = UIButton(type: .system)
		button.setImage(UIImage(named: "down"), for: .normal)
		button.tintColor = .white
		button.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
		view.addSubview(button)
		
		button.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			button.topAnchor.constraint(equalTo: view.topAnchor),
			button.widthAnchor.constraint(equalToConstant: 200),
			button.heightAnchor.constraint(equalToConstant: 80),
		])
	}
	
	@objc func dismissSelf() {
		self.dismiss(animated: true)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
