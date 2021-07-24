//
//  PhotosCollection module
//  Created by Artur Lutfullin on 03/07/2021.
//

import UIKit

protocol PhotosCollectionPresentationLogic {
    func showImages(response: PhotosCollection.LoadImages.Response)
}

/// Отвечает за отображение данных модуля PhotosCollection
class PhotosCollectionPresenter: PhotosCollectionPresentationLogic {
    weak var viewController: PhotosCollectionDisplayLogic?
    // MARK: Do something
    func showImages(response: PhotosCollection.LoadImages.Response) {
        var viewModel: PhotosCollection.LoadImages.ViewModel

        switch response.result {
        case let .failure(error):
            viewModel = PhotosCollection.LoadImages.ViewModel(state: .error(message: error.localizedDescription))
        case let .success(data):
            if data.isEmpty {
                viewModel = PhotosCollection.LoadImages.ViewModel(state: .emptyResult)
            } else {
				viewModel = PhotosCollection.LoadImages.ViewModel(state: .result(data))
			}
		}
        viewController?.displaySomething(viewModel: viewModel)
    }
}
