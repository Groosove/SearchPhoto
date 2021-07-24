//
//  RecentHeaderView.swift
//  SearchPhoto
//
//  Created by Артур Лутфуллин on 24.07.2021.
//

import UIKit

class RecentHeaderView: UITableViewHeaderFooterView {
	static let identifier = "RecentHeaderViewId"
	weak var delegate: PhotosCollectionViewControllerDelegate?
	lazy var headerView: UILabel = {
		let label = UILabel()
		label.text = "Recents"
		label.textColor = .white
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	lazy var clearRecents: UIButton = {
		let button = UIButton()
		button.setTitle("Clear", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(delegate, action: #selector(deleteRecents), for: .touchUpInside)
		return button
	}()

	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		addSubviews()
		makeConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func addSubviews() {
		self.addSubview(headerView)
		self.addSubview(clearRecents)
	}
	
	private func makeConstraints() {
		let headerViewConstraints = [
			headerView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
			headerView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor)
		]
		
		let clearRecentsConstraints = [
			clearRecents.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
			clearRecents.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor)
		]
		NSLayoutConstraint.activate(headerViewConstraints)
		NSLayoutConstraint.activate(clearRecentsConstraints)
	}
	
	@objc private func deleteRecents() {
		delegate?.deleteAllRecents()
	}
}
