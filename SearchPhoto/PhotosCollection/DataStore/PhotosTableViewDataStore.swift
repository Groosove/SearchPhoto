//
//  PhotosTableViewDataStore.swift
//  SearchPhoto
//
//  Created by Fenix Lavon on 7/5/21.
//

import UIKit

class PhotosTableViewDataStore: NSObject, UITableViewDataSource {
    var models: [PhotosCollectionViewModel]
	init (models: [PhotosCollectionViewModel] = []) {
        self.models = models
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as? PhotosTableViewCell
        guard let recent = cell else { return UITableViewCell() }
		DispatchQueue.global(qos: .userInteractive).sync {
            recent.configure(image: self.models[indexPath.row].imageURL,
                             photograph: self.models[indexPath.row].name,
							 blurHash: self.models[indexPath.row].blurHash)
        }
        return recent
    }
}
