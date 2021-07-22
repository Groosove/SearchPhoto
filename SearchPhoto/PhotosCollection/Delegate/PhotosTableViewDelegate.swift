//
//  PhotosTableViewDelegate.swift
//  SearchPhoto
//
//  Created by Fenix Lavon on 7/5/21.
//

import UIKit

class PhotosTableViewDelegate: NSObject, UITableViewDelegate {
	var models: [PhotosCollectionModel]
    var result: PhotoViewerModel?
	weak var delegate: PhotosCollectionViewControllerDelegate?

	init(models: [PhotosCollectionModel] = []) {
		self.models = models
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		let imageRatio = models[indexPath.row].width / models[indexPath.row].height
		return UIScreen.main.bounds.width / imageRatio
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		guard let imageCell = tableView.cellForRow(at: indexPath) as? PhotosTableViewCell else { return }
        let image = UIImageView()
        image.loadImage(imageURL: models[indexPath.row].urls.regular)
        if image.image == nil {
            return
        }
        result = PhotoViewerModel(uid: models[indexPath.row].uid,
                                  name: models[indexPath.row].user.name,
                                  image: image,
                                  width: imageCell.frame.width,
                                  height: imageCell.frame.height,
                                  imageURL: models[indexPath.row].urls.regular)
        delegate?.openViewer(with: result!)
	}
}
