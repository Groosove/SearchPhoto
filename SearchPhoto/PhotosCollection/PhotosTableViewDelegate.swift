//
//  PhotosTableViewDelegate.swift
//  SearchPhoto
//
//  Created by Fenix Lavon on 7/5/21.
//

import UIKit

class PhotosTableViewDelegate: NSObject, UITableViewDelegate {
	var models: [PhotosCollectionModel]
    var result = [PhotoViewerModel]()
	weak var delegate: PhotosCollectionViewControllerDelegate?
	
	init(models: [PhotosCollectionModel] = []) {
		self.models = models
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		let imageRatio = models[indexPath.row].width / models[indexPath.row].height
		return UIScreen.main.bounds.width / imageRatio
	}
    
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? PhotosTableViewCell
        guard let imageCell = cell else { return }
		tableView.deselectRow(at: indexPath, animated: true)
        delegate?.openViewer(image: imageCell.photoView, uid: models[indexPath.row].id, user: models[indexPath.row].user.name)
	}
	
}
