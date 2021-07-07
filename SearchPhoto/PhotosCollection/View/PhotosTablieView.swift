//
//  PhotosTablieView.swift
//  SearchPhoto
//
//  Created by Fenix Lavon on 7/5/21.
//

import UIKit

class PhotosTablieView: UIView {
	private lazy var tableView: UITableView = {
		let tableView = UITableView.init(frame: .zero, style: .plain)
		tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
		tableView.tableHeaderView = UIView()
		tableView.tableFooterView = UIView()
		tableView.backgroundColor = .black
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubviews()
		makeConstraints()
		backgroundColor = .black
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    private func addSubviews() {
        addSubview(tableView)
    }

    private func makeConstraints() {
		let tableViewViewConstaints = [
			tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
			tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
		]
		
		NSLayoutConstraint.activate(tableViewViewConstaints)
    }
	
	func updateTableViewData(delegate: UITableViewDelegate, dataSource: UITableViewDataSource, tabBarHeight: CGFloat) {
		tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: tabBarHeight, right: 0)
		tableView.delegate = delegate
		tableView.dataSource = dataSource
		tableView.reloadData()
	}
}
