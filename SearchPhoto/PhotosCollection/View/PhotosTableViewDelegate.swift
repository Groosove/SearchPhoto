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
	
//	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//		let imageRatio = CGFloat(models[indexPath.row].width) / CGFloat(models[indexPath.row].height)
//		return UIScreen.main.bounds.width / imageRatio
//	}
}
