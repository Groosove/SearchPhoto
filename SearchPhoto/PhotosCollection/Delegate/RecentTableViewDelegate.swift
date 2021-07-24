//
//  RecentTableViewDelegate.swift
//  SearchPhoto
//
//  Created by Fenix Lavon on 7/10/21.
//

import UIKit

final class RecentTableViewDelegate: NSObject, UITableViewDelegate {
    var models: [Recent]
    weak var delegate: PhotosCollectionViewControllerDelegate?
    init(models: [Recent] = []) {
        self.models = models
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let searchBar = UISearchBar()
        searchBar.text = models[indexPath.row].search
        delegate?.updateSearchResults(with: models[indexPath.row].search)
    }
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: RecentHeaderView.identifier) as? RecentHeaderView
		guard let headerView = view else { return UIView() }
		headerView.delegate = delegate
		headerView.tintColor = .black
		return headerView
	}
	
	@objc private func deleteRecents() {
		delegate?.deleteAllRecents()
	}
}
