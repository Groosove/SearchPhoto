//
//  Created by Artur Lutfullin on 17/07/2021.
//

import UIKit

protocol RandomImagesServiceProtocol {
    func getImages(completion: @escaping ([PhotosCollectionModel]?, Error?) -> Void)
}

/// Получает данные для модуля RandomImages
class RandomImagesService: RandomImagesServiceProtocol {
    let httpHandler = HTTPHandler()
    private let decoder: JSONDecoder = JSONDecoder()

    func getImages(completion: @escaping ([PhotosCollectionModel]?, Error?) -> Void) {
        let parametrs = ["count": "15", "client_id": Unsplash.API.clientId]
        httpHandler.get(baseURL: Unsplash.baseURL, endPoint: Unsplash.Methods.gerRandomImage, parametrs: parametrs) { result in
            switch result {
            case let .success(data):
                do {
                    let models = try self.decoder.decode(UnsplashPhoto.self, from: data)
                    completion(models.results, nil)
                }
                catch { completion(nil, PhotosCollectionServiceError.decodeJSON) }
            case let .failure(error):
                completion(nil, error)
            }
        }
    }
}
