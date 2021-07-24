//
//  Created by Artur Lutfullin on 17/07/2021.
//

import UIKit

final class RandomImagesDataStore: NSObject, UICollectionViewDataSource {
    var models: [PhotosCollectionModel]

    init (models: [PhotosCollectionModel] = []) {
        self.models = models
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RandomImagesViewCell.identifier, for: indexPath) as? RandomImagesViewCell
        guard let photo = cell else { return UICollectionViewCell() }
        photo.configure(image: models[indexPath.item].urls.regular, photograph: models[indexPath.item].user.name)
        return photo
    }
}
