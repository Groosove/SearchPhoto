//
//  Created by Artur Lutfullin on 17/07/2021.
//

import UIKit

/// Протокол
protocol RandomImagesServiceProtocol {

	/// Получить изображние
	/// Parameter completion:  Результат выполнения запроса
	func getImages(completion: @escaping ([PhotosCollectionModel]?, Error?) -> Void)
}

final class RandomImagesService: RandomImagesServiceProtocol {
	private let httpHandler = HTTPHandler()
	private let decoder = JSONDecoder()

	func getImages(completion: @escaping ([PhotosCollectionModel]?, Error?) -> Void) {
		let parametrs = ["count": "30", "client_id": Unsplash.API.clientId]
		httpHandler.get(baseURL: Unsplash.baseURL, endPoint: Unsplash.Methods.getRandomImage, parametrs: parametrs) { result in
			switch result {
			case let .success(data):
				do {
					let models = try self.decoder.decode([PhotosCollectionModel].self, from: data)
					completion(models, nil)
				} catch { completion(nil, PhotosCollectionServiceError.endCountRequestApi) }

			case let .failure(error):
				completion(nil, error)
			}
		}
	}
}
