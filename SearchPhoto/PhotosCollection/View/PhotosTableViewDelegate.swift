//
//  PhotosTableViewDelegate.swift
//  SearchPhoto
//
//  Created by Fenix Lavon on 7/5/21.
//

import UIKit

class PhotosTableViewDelegate: NSObject, UITableViewDelegate {
	var models: [PhotosCollectionViewModel]
	
	init(models: [PhotosCollectionViewModel] = []) {
		self.models = models
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		let currentImage = models[indexPath.row].image
		let imageRatio = currentImage.getImageRatio()
		return tableView.frame.width / imageRatio
	}
}

private extension UIImage {
	func getImageRatio() -> CGFloat {
		let imageRatio = CGFloat(self.size.width / self.size.height)
		return imageRatio
	}
}
