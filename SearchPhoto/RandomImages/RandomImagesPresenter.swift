//
//  RandomImages module
//  Created by Artur Lutfullin on 17/07/2021.
//

import UIKit

protocol RandomImagesPresentationLogic {
    func presentSomething(response: RandomImages.LoadImage.Response)
}

/// Отвечает за отображение данных модуля RandomImages
class RandomImagesPresenter: RandomImagesPresentationLogic {
    weak var viewController: RandomImagesDisplayLogic?

    // MARK: Do something
    func presentSomething(response: RandomImages.LoadImage.Response) {
        var viewModel: RandomImages.LoadImage.ViewModel

        switch response.result {
        case let .failure(error):
            viewModel = RandomImages.LoadImage.ViewModel(state: .error(message: error.localizedDescription))
        case let .success(result):
            if result.isEmpty {
                viewModel = RandomImages.LoadImage.ViewModel(state: .emptyResult)
            } else {
                viewModel = RandomImages.LoadImage.ViewModel(state: .result(result))
            }
        }
        viewController?.displaySomething(viewModel: viewModel)
    }
}
