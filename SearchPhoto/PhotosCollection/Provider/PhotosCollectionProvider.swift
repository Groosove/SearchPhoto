//
//  Created by Artur Lutfullin on 03/07/2021.
//

protocol PhotosCollectionProviderProtocol {
    func getItems(with searchItem: String, completion: @escaping ([PhotosCollectionModel]?, PhotosCollectionProviderError?) -> Void)
}

enum PhotosCollectionProviderError: Error {
    case getItemsFailed(underlyingError: Error)
}

struct PhotosCollectionProvider: PhotosCollectionProviderProtocol {
    let dataStore: PhotosTableViewDataStore
    let service: PhotosCollectionServiceProtocol

    init(dataStore: PhotosTableViewDataStore = PhotosTableViewDataStore(), service: PhotosCollectionServiceProtocol = PhotosCollectionService()) {
        self.dataStore = dataStore
        self.service = service
    }

    func getItems(with searchItem: String, completion: @escaping ([PhotosCollectionModel]?, PhotosCollectionProviderError?) -> Void) {
        service.getImages(with: searchItem) { (array, error) in
            if let error = error {
                completion(nil, .getItemsFailed(underlyingError: error))
            } else if let models = array {
				completion(models, nil)
            } else {
                completion(nil, nil)
            }
		}
    }
}
