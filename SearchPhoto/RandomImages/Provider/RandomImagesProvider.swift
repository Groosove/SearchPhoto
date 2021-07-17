//
//  Created by Artur Lutfullin on 17/07/2021.
//

protocol RandomImagesProviderProtocol {
    func getItems(completion: @escaping ([RandomImagesModel]?, RandomImagesProviderError?) -> Void)
}

enum RandomImagesProviderError: Error {
    case getItemsFailed(underlyingError: Error)
}

/// Отвечает за получение данных модуля RandomImages
struct RandomImagesProvider: RandomImagesProviderProtocol {
    let dataStore: RandomImagesDataStore
    let service: RandomImagesServiceProtocol

    init(dataStore: RandomImagesDataStore = RandomImagesDataStore(), service: RandomImagesServiceProtocol = RandomImagesService()) {
        self.dataStore = dataStore
        self.service = service
    }

    func getItems(completion: @escaping ([RandomImagesModel]?, RandomImagesProviderError?) -> Void) {
        if dataStore.models?.isEmpty == false {
            return completion(self.dataStore.models, nil)
        }
        service.fetchItems { (array, error) in
            if let error = error {
                completion(nil, .getItemsFailed(underlyingError: error))
            } else if let models = array {
                self.dataStore.models = models
                completion(self.dataStore.models, nil)
            }
        }
    }
}
