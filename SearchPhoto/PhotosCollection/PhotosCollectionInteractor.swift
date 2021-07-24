//
//  PhotosCollection module
//  Created by Artur Lutfullin on 03/07/2021.
//

protocol PhotosCollectionBusinessLogic {
    func findPhoto(request: PhotosCollection.LoadImages.Request)
}

/// Класс для описания бизнес-логики модуля PhotosCollection
class PhotosCollectionInteractor: PhotosCollectionBusinessLogic {
    let presenter: PhotosCollectionPresentationLogic
    let provider: PhotosCollectionProviderProtocol

	init(presenter: PhotosCollectionPresentationLogic, provider: PhotosCollectionProviderProtocol = PhotosCollectionProvider()) {
        self.presenter = presenter
        self.provider = provider
    }

    // MARK: Find Photo
    func findPhoto(request: PhotosCollection.LoadImages.Request) {
		provider.getItems(with: request.search) { (items, error) in
            let result: PhotosCollection.PhotosCollectionRequestResult
            if let items = items {
                result = .success(items)
            } else if let error = error {
                result = .failure(.someError(message: error.localizedDescription))
            } else {
                result = .failure(.someError(message: "No Data"))
            }
            self.presenter.showImages(response: PhotosCollection.LoadImages.Response(result: result))
        }
    }
}
