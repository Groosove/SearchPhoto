//
//  RecentTableView.swift
//  SearchPhoto
//
//  Created by Артур Лутфуллин on 09.07.2021.
//

import UIKit

class RecentTableView: UIView {
	private lazy var spinnerView: UIActivityIndicatorView = {
		let spinner = UIActivityIndicatorView(style: .medium)
		spinner.center = self.center
		return spinner
	}()
	
	private lazy var tableView: UITableView = {
		let tableView = UITableView.init(frame: .zero, style: .plain)
		tableView.register(RecentTableViewCell.self, forCellReuseIdentifier: RecentTableViewCell.identifier)
		tableView.tableHeaderView = UIView()
		tableView.tableFooterView = UIView()
		tableView.backgroundColor = .white
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
	
	func updateTableViewData(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
		tableView.delegate = delegate
		tableView.dataSource = dataSource
		tableView.reloadData()
	}
}
