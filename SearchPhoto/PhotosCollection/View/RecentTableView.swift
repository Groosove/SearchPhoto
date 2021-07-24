//
//  RecentTableView.swift
//  SearchPhoto
//
//  Created by Артур Лутфуллин on 09.07.2021.
//

import UIKit

class RecentTableView: UIView {
    lazy var recentTableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
		tableView.register(RecentTableViewCell.self, forCellReuseIdentifier: RecentTableViewCell.identifier)
		tableView.register(RecentHeaderView.self, forHeaderFooterViewReuseIdentifier: RecentHeaderView.identifier)
		tableView.tableFooterView = UIView()
		tableView.estimatedSectionHeaderHeight = 70
		tableView.backgroundColor = .black
        tableView.separatorColor = .white
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
			recentTableView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
			recentTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			recentTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			recentTableView.topAnchor.constraint(equalTo: self.topAnchor)
		]
        NSLayoutConstraint.activate(tableViewViewConstaints)
	}

    func updateTableViewData(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        recentTableView.contentInset = UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
		recentTableView.delegate = delegate
		recentTableView.dataSource = dataSource
		recentTableView.reloadData()
	}
}
