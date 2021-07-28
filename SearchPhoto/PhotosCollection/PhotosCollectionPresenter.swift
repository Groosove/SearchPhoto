//
//  PhotosCollection module
//  Created by Artur Lutfullin on 03/07/2021.
//

import UIKit

protocol PhotosCollectionPresentationLogic {
    func showImages(response: PhotosCollection.LoadImages.Response)
}


final class PhotosCollectionPresenter: PhotosCollectionPresentationLogic {
    weak var viewController: PhotosCollectionDisplayLogic?
    func showImages(response: PhotosCollection.LoadImages.Response) {
        var viewModel: PhotosCollection.LoadImages.ViewModel

        switch response.result {
        case .failure:
            viewModel = PhotosCollection.LoadImages.ViewModel(state: .error(message: "Check your internet connection"))
        case let .success(data):
            if data.isEmpty {
                viewModel = PhotosCollection.LoadImages.ViewModel(state: .emptyResult)
            } else {
                let result = processingData(data: data)
				viewModel = PhotosCollection.LoadImages.ViewModel(state: .result(result))
			}
		}
        viewController?.displayImages(viewModel: viewModel)
    }

    private func processingData(data: [PhotosCollectionModel]) -> [PhotosCollectionViewModel] {
        let result = data.map { PhotosCollectionViewModel(uid: $0.uid,
                                                          width: $0.width,
                                                          height: $0.height,
                                                          blurHash: $0.blurHash,
                                                          name: $0.user.name,
                                                          imageURL: $0.urls.regular)
        }
        return result
    }
}
