//
//  RandomImages module
//  Created by Artur Lutfullin on 17/07/2021.
//

enum RandomImages {

	enum LoadImage {

		// swiftlint:disable nesting
		struct Request {}

		struct Response {
			var result: RandomImagesRequestResult
		}

		struct ViewModel {
			var state: ViewControllerState
		}
		// swiftlint:enable nesting
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
		case loadImageErrror(message: String)
	}
}
