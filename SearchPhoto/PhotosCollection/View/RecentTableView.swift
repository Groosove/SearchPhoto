//
//  RecentTableView.swift
//  SearchPhoto
//
//  Created by Артур Лутфуллин on 09.07.2021.
//

import UIKit

class RecentTableView: UIView {
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
    lazy var recentTableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
		tableView.register(RecentTableViewCell.self, forCellReuseIdentifier: RecentTableViewCell.identifier)
		tableView.tableHeaderView = UIView()
		tableView.sectionHeaderHeight = 70
		tableView.tableFooterView = UIView()
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
        addSubview(headerView)
        addSubview(clearRecents)
	}

	private func makeConstraints() {
        let headerViewConstarits = [
            headerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            headerView.bottomAnchor.constraint(equalTo: recentTableView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 10)
        ]

        let clearRecentsConstraints = [
            clearRecents.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            clearRecents.bottomAnchor.constraint(equalTo: recentTableView.topAnchor, constant: -5),
            clearRecents.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor)
        ]

		let tableViewViewConstaints = [
			recentTableView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
			recentTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			recentTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
		]

        NSLayoutConstraint.activate(headerViewConstarits)
        NSLayoutConstraint.activate(clearRecentsConstraints)
        NSLayoutConstraint.activate(tableViewViewConstaints)
	}

    @objc private func deleteRecents() {
        delegate?.deleteAllRecents()
    }

    func updateTableViewData(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        recentTableView.contentInset = UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
		recentTableView.delegate = delegate
		recentTableView.dataSource = dataSource
		recentTableView.reloadData()
	}
}
