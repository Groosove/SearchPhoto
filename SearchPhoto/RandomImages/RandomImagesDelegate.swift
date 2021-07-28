//
//  RandomImagesWaterfallDelegate.swift
//  SearchPhoto
//
//  Created by Fenix Lavon on 7/17/21.
//

import UIKit

final class RandomImagesDelegate: NSObject, UICollectionViewDelegate {
    var models: [PhotosCollectionModel]
    weak var delegate: RandomImagesViewControllerDelegate?

    init(models: [PhotosCollectionModel] = []) {
        self.models = models
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
		guard let photoCell = collectionView.cellForItem(at: indexPath) as? RandomImagesViewCell, !photoCell.isLoading else { return }
        let item = models[indexPath.item]
        let imageRatio = item.width / item.height
        let height = UIScreen.main.bounds.width / imageRatio
        let result = PhotoViewerModel(uid: item.uid,
                                      name: item.user.name,
									  image: photoCell.photoView,
                                      width: UIScreen.main.bounds.width,
                                      height: height,
                                      imageURL: item.urls.regular)
        delegate?.openViewer(with: result)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastElement = models.count - 1

        if indexPath.item == lastElement {
            delegate?.loadImages()
        }
    }
}
