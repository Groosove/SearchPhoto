//
//  RandomImages module
//  Created by Artur Lutfullin on 17/07/2021.
//

import UIKit

protocol RandomImagesPresentationLogic {

	/// Показать изображения
	/// - Parameter response: Загруженные изображения
	func presentImages(response: RandomImages.LoadImage.Response)
}

final class RandomImagesPresenter: RandomImagesPresentationLogic {
	weak var viewController: RandomImagesDisplayLogic?

	func presentImages(response: RandomImages.LoadImage.Response) {
		var viewModel: RandomImages.LoadImage.ViewModel

		switch response.result {
		case .failure:
			viewModel = RandomImages.LoadImage.ViewModel(state: .error(message: "Check your internet connection"))

		case let .success(result):
			if result.isEmpty {
				viewModel = RandomImages.LoadImage.ViewModel(state: .emptyResult)
			} else {
				viewModel = RandomImages.LoadImage.ViewModel(state: .result(result))
			}
		}
		viewController?.displayImages(viewModel: viewModel)
	}
}
