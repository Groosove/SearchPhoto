//
//  Created by Artur Lutfullin on 03/07/2021.
//

import UIKit
class PhotosCollectionDataStore: NSObject, UICollectionViewDataSource {
    var models: [PhotosCollectionModel]
	
	init(models: [PhotosCollectionModel] = []) {
		self.models = models
	}
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return models.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
		let _ = models[indexPath.item]
		return cell
	}

}
