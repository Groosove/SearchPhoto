//
//  PhotosCollection module
//  Created by Artur Lutfullin on 03/07/2021.
//

protocol PhotosCollectionBusinessLogic {

	func findPhoto(request: PhotosCollection.LoadImages.Request)
}

final class PhotosCollectionInteractor: PhotosCollectionBusinessLogic {

	private let presenter: PhotosCollectionPresentationLogic
	private let provider: PhotosCollectionProviderProtocol

	init(presenter: PhotosCollectionPresentationLogic, provider: PhotosCollectionProviderProtocol = PhotosCollectionProvider()) {
		self.presenter = presenter
		self.provider = provider
	}

	func findPhoto(request: PhotosCollection.LoadImages.Request) {
		provider.getItems(with: request.search) { items, _ in
			let result: PhotosCollection.PhotosCollectionRequestResult

			if let items = items {
				result = .success(items)
			} else {
				result = .failure(.loadImageError(message: "Check internet connection"))
			}
			self.presenter.showImages(response: PhotosCollection.LoadImages.Response(result: result))
		}
	}
}
