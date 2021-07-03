//
//  PhotosCollection module
//  Created by Artur Lutfullin on 03/07/2021.
//

enum PhotosCollection {
    // MARK: Use cases
    enum Something {
		// swiftlint:disable nesting
        struct Request {
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
        case success([UnsplashPhoto])
    }

    enum ViewControllerState {
        case loading
        case result([UnsplashPhoto])
        case emptyResult
        case error(message: String)
    }

    enum PhotosCollectionError: Error {
        case someError(message: String)
    }
}
