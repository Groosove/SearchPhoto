//
//  RandomImages module
//  Created by Artur Lutfullin on 17/07/2021.
//

import UIKit

class RandomImagesBuilder: ModuleBuilder {

    var initialState: RandomImages.ViewControllerState?

    func set(initialState: RandomImages.ViewControllerState) -> RandomImagesBuilder {
        self.initialState = initialState
        return self
	}

    func build() -> UIViewController {
        let presenter = RandomImagesPresenter()
        let interactor = RandomImagesInteractor(presenter: presenter)
        let controller = RandomImagesViewController(interactor: interactor)

        presenter.viewController = controller
        return controller
    }
}
