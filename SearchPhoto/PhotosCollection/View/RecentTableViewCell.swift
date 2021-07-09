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
	}

	override func prepareForReuse() {
		super.prepareForReuse()
	}
	
	private func makeConstraints() {
	}
	
	func configure(image: String, photograph: String) {
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
