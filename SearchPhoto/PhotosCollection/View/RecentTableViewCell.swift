//
//  RecentTableViewCell.swift
//  SearchPhoto
//
//  Created by Артур Лутфуллин on 09.07.2021.
//

import UIKit

extension RecentTableViewCell {
    struct Appearance {
        let exampleOffset: CGFloat = 5
    }
}

final class RecentTableViewCell: UITableViewCell {
	static let identifier = "RecentTableViewCellId"
    private let appearance = Appearance()
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

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(recent: String) {
        searchLabel.text = recent
    }

	private func addSubviews() {
        addSubview(searchLabel)
	}

	private func makeConstraints() {
        let searchLabelContsraints = [
            searchLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: appearance.exampleOffset),
            searchLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            searchLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            searchLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -appearance.exampleOffset)
        ]
        NSLayoutConstraint.activate(searchLabelContsraints)
	}
}
