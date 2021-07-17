//
//  RandomImages module
//  Created by Artur Lutfullin on 17/07/2021.
//

import UIKit

protocol RandomImagesPresentationLogic {
    func presentSomething(response: RandomImages.Something.Response)
}

/// Отвечает за отображение данных модуля RandomImages
class RandomImagesPresenter: RandomImagesPresentationLogic {
    weak var viewController: RandomImagesDisplayLogic?

    // MARK: Do something
    func presentSomething(response: RandomImages.Something.Response) {
        var viewModel: RandomImages.Something.ViewModel
        
        switch response.result {
        case let .failure(error):
            viewModel = RandomImages.Something.ViewModel(state: .error(message: error.localizedDescription))
        case let .success(result):
            if result.isEmpty {
                viewModel = RandomImages.Something.ViewModel(state: .emptyResult)
            } else {
                viewModel = RandomImages.Something.ViewModel(state: .result(result))
            }
        }
        
        viewController?.displaySomething(viewModel: viewModel)
    }
}
