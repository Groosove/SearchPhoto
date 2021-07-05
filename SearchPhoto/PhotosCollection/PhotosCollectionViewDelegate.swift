//
//  PhotosCollectionViewDelegate.swift
//  SearchPhoto
//
//  Created by Артур Лутфуллин on 05.07.2021.
//

import UIKit

class PhotosCollectionViewDelegate: NSObject, UICollectionViewDelegate {
	var models: [PhotosCollectionModel]
	private let itemsPerRow: CGFloat = 2
	private let sectionInsert = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
	private let viewWidth: CGFloat
	init(models: [PhotosCollectionModel] = [], width: CGFloat) {
		self.models = models
		self.viewWidth = width
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let photo = models[indexPath.item]
		let paddingSpace = sectionInsert.left * (itemsPerRow + 1)
		let availableWidth = viewWidth - paddingSpace
		let widthPerItem = availableWidth / itemsPerRow
		let height = CGFloat(photo.height) * widthPerItem / CGFloat(photo.width)
		return CGSize(width: widthPerItem, height: height)
	}
		
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return sectionInsert
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return sectionInsert.left
	}
}
