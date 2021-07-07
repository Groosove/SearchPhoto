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
				var result = [PhotosCollectionViewModel]()
					for item in data {
						let imageView = self.loadImage(url: item.urls.regular)
						result.append(PhotosCollectionViewModel(uid: item.id, image: imageView, authorName: item.user.name))
					}
				viewModel = PhotosCollection.Something.ViewModel(state: .result(result))
			}
		}
        viewController?.displaySomething(viewModel: viewModel)
    }
	
	private func loadImage(url: String) -> UIImage {
		DispatchQueue.global().sync {
			guard let url = URL(string: url) else { return UIImage() }
				if let data = try? Data(contentsOf: url) {
					if let image = UIImage(data: data) {
						return image
					}
				}
			return UIImage()
		}
		
	}
}
