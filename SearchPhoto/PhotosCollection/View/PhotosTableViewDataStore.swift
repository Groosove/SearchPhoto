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
<<<<<<< HEAD
		recent.configure(image: models[indexPath.row].urls.regular, photograph: models[indexPath.row].user.name)
=======
		var image = UIImage()
		loadImage(url: models[indexPath.row].urls.regular) { loadImage in
			image = loadImage
			recent.configure(image: image, photograph: self.models[indexPath.row].user.name)
		}

>>>>>>> 566399d114441bebbf4ebdcd15aeac1f525b4810
        return recent
    }
	
	private func loadImage(url: String, completion: @escaping (UIImage) -> Void) {
		guard let url = URL(string: url) else { return }
			if let data = try? Data(contentsOf: url) {
				if let image = UIImage(data: data) {
					completion(image)
			}
		}
	}
}
