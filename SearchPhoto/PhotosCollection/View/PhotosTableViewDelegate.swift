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
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		let imageRatio = models[indexPath.row].width / models[indexPath.row].height
		return UIScreen.main.bounds.width / imageRatio
	}
    
//    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//
//        let currentOffset = scrollView.contentOffset.y
//        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
//
//        if maximumOffset - currentOffset <= 10.0 {}
//    }
}
