//
//  RecentTableView.swift
//  SearchPhoto
//
//  Created by Артур Лутфуллин on 09.07.2021.
//

import UIKit

class RecentTableView: UIView {
	private lazy var recentTableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
		tableView.register(RecentTableViewCell.self, forCellReuseIdentifier: RecentTableViewCell.identifier)
		tableView.tableHeaderView = UIView()
		tableView.tableFooterView = UIView()
		tableView.backgroundColor = .white
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}()
    
    private lazy var trendingTableView: UITableView = {
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
		addSubview(recentTableView)
	}

	private func makeConstraints() {
		let tableViewViewConstaints = [
			recentTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
			recentTableView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
			recentTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			recentTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
		]
		NSLayoutConstraint.activate(tableViewViewConstaints)
	}
	
	func updateTableViewData(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
		recentTableView.delegate = delegate
		recentTableView.dataSource = dataSource
		recentTableView.reloadData()
	}
}
