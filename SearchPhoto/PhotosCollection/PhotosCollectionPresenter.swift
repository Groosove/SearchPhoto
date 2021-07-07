//
//  PhotosCollection module
//  Created by Artur Lutfullin on 03/07/2021.
//

import UIKit

protocol PhotosCollectionPresentationLogic {
    func showImages(response: PhotosCollection.Something.Response)
}

/// Отвечает за отображение данных модуля PhotosCollection
class PhotosCollectionPresenter: PhotosCollectionPresentationLogic {
    weak var viewController: PhotosCollectionDisplayLogic?
    // MARK: Do something
    func showImages(response: PhotosCollection.Something.Response) {
        var viewModel: PhotosCollection.Something.ViewModel

        switch response.result {
        case let .failure(error):
            viewModel = PhotosCollection.Something.ViewModel(state: .error(message: error.localizedDescription))
        case let .success(data):
            if data.isEmpty {
                viewModel = PhotosCollection.Something.ViewModel(state: .emptyResult)
			} else {
				viewModel = PhotosCollection.Something.ViewModel(state: .result(data))
			}
		}
        viewController?.displaySomething(viewModel: viewModel)
    }
}
