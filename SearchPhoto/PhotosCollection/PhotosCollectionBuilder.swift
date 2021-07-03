//
//  PhotosCollection module
//  Created by Artur Lutfullin on 03/07/2021.
//

import UIKit

protocol ModuleBuilder {
	func build() -> UIViewController
}

class PhotosCollectionBuilder: ModuleBuilder {

    var initialState: PhotosCollection.ViewControllerState?

    func set(initialState: PhotosCollection.ViewControllerState) -> PhotosCollectionBuilder {
        self.initialState = initialState
        return self
    }

    func build() -> UIViewController {
        let presenter = PhotosCollectionPresenter()
        let interactor = PhotosCollectionInteractor(presenter: presenter)
        let controller = PhotosCollectionViewController(interactor: interactor)

        presenter.viewController = controller
        return controller
    }
}
