//
//  RandomImages module
//  Created by Artur Lutfullin on 17/07/2021.
//

enum RandomImages {
    // MARK: Use cases
    enum Something {
        struct Request {
        }

        struct Response {
            var result: RandomImagesRequestResult
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }

    enum RandomImagesRequestResult {
        case failure(RandomImagesError)
        case success([PhotosCollectionModel])
    }

    enum ViewControllerState {
        case loading
        case result([PhotosCollectionModel])
        case emptyResult
        case error(message: String)
    }

    enum RandomImagesError: Error {
        case someError(message: String)
    }
}
