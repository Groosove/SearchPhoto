//
//  RecentTableViewCell.swift
//  SearchPhoto
//
//  Created by Артур Лутфуллин on 09.07.2021.
//

import UIKit

class RecentTableViewCell: UITableViewCell {
	static let identifier = "RecentTableViewCellId"
	
	private lazy var searchLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .white
		return label
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = .black
		addSubviews()
		makeConstraints()
	}
	
	private func addSubviews() {
        addSubview(searchLabel)
	}

	
	private func makeConstraints() {
        let searchLabelContsraints = [
            searchLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            searchLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            searchLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            searchLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
        ]
        
        NSLayoutConstraint.activate(searchLabelContsraints)
	}
	
    func configure(recent: String) {
        searchLabel.text = recent
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}