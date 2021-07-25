//
//  Created by Artur Lutfullin on 17/07/2021.
//

import UIKit

protocol RandomImagesServiceProtocol {
    func getImages(completion: @escaping ([PhotosCollectionModel]?, Error?) -> Void)
}

final class RandomImagesService: RandomImagesServiceProtocol {
    private let httpHandler = HTTPHandler()
    private let decoder: JSONDecoder = JSONDecoder()

    func getImages(completion: @escaping ([PhotosCollectionModel]?, Error?) -> Void) {
        let parametrs = ["count": "30", "client_id": Unsplash.API.clientId]
        httpHandler.get(baseURL: Unsplash.baseURL, endPoint: Unsplash.Methods.getRandomImage, parametrs: parametrs) { result in
            switch result {
            case let .success(data):
                do {
                    let models = try self.decoder.decode([PhotosCollectionModel].self, from: data)
                    completion(models, nil)
                } catch { completion(nil, PhotosCollectionServiceError.decodeJSON) }
            case let .failure(error):
                completion(nil, error)
            }
        }
    }
}
