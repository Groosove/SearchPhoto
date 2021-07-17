//
//  Created by Artur Lutfullin on 17/07/2021.
//

protocol RandomImagesServiceProtocol {
    func fetchItems(completion: @escaping ([RandomImagesModel]?, Error?) -> Void)
}

/// Получает данные для модуля RandomImages
class RandomImagesService: RandomImagesServiceProtocol {

    func fetchItems(completion: @escaping ([RandomImagesModel]?, Error?) -> Void) {
        completion(nil, nil)
    }
}
