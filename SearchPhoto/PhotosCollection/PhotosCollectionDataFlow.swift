//
//  PhotosCollection module
//  Created by Artur Lutfullin on 03/07/2021.
//

enum PhotosCollection {
    enum LoadImages {
		// swiftlint:disable nesting
        struct Request {
            var search: String
        }

        struct Response {
            var result: PhotosCollectionRequestResult
		}

        struct ViewModel {
            var state: ViewControllerState
        }
		// swiftlint:enable nesting
    }

    enum PhotosCollectionRequestResult {
        case failure(PhotosCollectionError)
        case success([PhotosCollectionModel])
    }

    enum ViewControllerState {
        case loading
        case result([PhotosCollectionModel])
        case emptyResult
        case error(message: String)
    }

    enum PhotosCollectionError: Error {
        case someError(message: String)
    }
}
