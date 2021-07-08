//
//  PhotosTableViewDataStore.swift
//  SearchPhoto
//
//  Created by Fenix Lavon on 7/5/21.
//

import UIKit

class PhotosTableViewDataStore: NSObject, UITableViewDataSource {
    var models: [PhotosCollectionModel]
    
    init (models: [PhotosCollectionModel] = []) {
        self.models = models
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as? PhotosTableViewCell
        guard let recent = cell else { return UITableViewCell() }
        DispatchQueue.global(qos: .userInitiated).async {
            recent.configure(image: self.models[indexPath.row].urls.regular, photograph: self.models[indexPath.row].user.name)
        }
        return recent
    }
}
