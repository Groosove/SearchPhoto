//
//  Created by Artur Lutfullin on 03/07/2021.
//

import UIKit

protocol PhotosCollectionServiceProtocol {
    func getImages(with name: String, completion: @escaping ([PhotosCollectionModel]?, Error?) -> Void)
}

enum PhotosCollectionServiceError: Error {
    case endCountRequestApi
}

final class PhotosCollectionService: PhotosCollectionServiceProtocol {
	private let httpHandler = HTTPHandler()
	private let decoder = JSONDecoder()

	func getImages(with name: String, completion: @escaping ([PhotosCollectionModel]?, Error?) -> Void) {
		let parametrs = ["query": name, "page": "1", "per_page": "50", "client_id": Unsplash.API.clientId]
		httpHandler.get(baseURL: Unsplash.baseURL, endPoint: Unsplash.Methods.getImages, parametrs: parametrs) { result in
			switch result {
			case let .success(data):
				do {
					let models = try self.decoder.decode(UnsplashPhoto.self, from: data)
					completion(models.results, nil)
				} catch { completion(nil, PhotosCollectionServiceError.endCountRequestApi) }

			case let .failure(error):
				completion(nil, error)
			}
		}
	}
}
