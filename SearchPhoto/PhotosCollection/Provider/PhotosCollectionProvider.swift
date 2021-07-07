//
//  Created by Artur Lutfullin on 03/07/2021.
//

protocol PhotosCollectionProviderProtocol {
    func getItems(with searchItem: String, completion: @escaping ([PhotosCollectionModel]?, PhotosCollectionProviderError?) -> Void)
}

enum PhotosCollectionProviderError: Error {
    case getItemsFailed(underlyingError: Error)
}

/// Отвечает за получение данных модуля PhotosCollection
struct PhotosCollectionProvider: PhotosCollectionProviderProtocol {
    let dataStore: PhotosCollectionDataStore
    let service: PhotosCollectionServiceProtocol

    init(dataStore: PhotosCollectionDataStore = PhotosCollectionDataStore(), service: PhotosCollectionServiceProtocol = PhotosCollectionService()) {
        self.dataStore = dataStore
        self.service = service
    }

    func getItems(with searchItem: String, completion: @escaping ([PhotosCollectionModel]?, PhotosCollectionProviderError?) -> Void) {
        service.getImages(with: searchItem) { (array, error) in
            if let error = error {
                completion(nil, .getItemsFailed(underlyingError: error))
            } else if let models = array {
				self.dataStore.models = models
				completion(self.dataStore.models, nil)
			}
		}
    }
}
