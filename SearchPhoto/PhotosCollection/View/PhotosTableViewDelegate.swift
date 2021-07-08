//
//  PhotosTableViewDelegate.swift
//  SearchPhoto
//
//  Created by Fenix Lavon on 7/5/21.
//

import UIKit

class PhotosTableViewDelegate: NSObject, UITableViewDelegate {
	var models: [PhotosCollectionModel]
	
	init(models: [PhotosCollectionModel] = []) {
		self.models = models
	}
	
<<<<<<< HEAD
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		let imageRatio = models[indexPath.row].width / models[indexPath.row].height
		return UIScreen.main.bounds.width / imageRatio
	}
}

private extension UIImage {
	func getImageRatio() -> CGFloat {
		let imageRatio = CGFloat(self.size.width / self.size.height)
		return imageRatio
	}
=======
//	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//		let imageRatio = CGFloat(models[indexPath.row].width) / CGFloat(models[indexPath.row].height)
//		return UIScreen.main.bounds.width / imageRatio
//	}
>>>>>>> 566399d114441bebbf4ebdcd15aeac1f525b4810
}
