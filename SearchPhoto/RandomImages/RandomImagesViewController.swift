//
//  RandomImages module
//  Created by Artur Lutfullin on 17/07/2021.
//

import UIKit

protocol RandomImagesDisplayLogic: class {
    func displaySomething(viewModel: RandomImages.Something.ViewModel)
}

class RandomImagesViewController: UIViewController {
    let interactor: RandomImagesBusinessLogic
    var state: RandomImages.ViewControllerState

    init(interactor: RandomImagesBusinessLogic, initialState: RandomImages.ViewControllerState = .loading) {
        self.interactor = interactor
        self.state = initialState
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View lifecycle
    override func loadView() {
        let view = RandomImagesView(frame: UIScreen.main.bounds)
        self.view = view
        // make additional setup of view or save references to subviews
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
    }

    // MARK: Do something
    func doSomething() {
        let request = RandomImages.Something.Request()
        interactor.doSomething(request: request)
    }
}

extension RandomImagesViewController: RandomImagesDisplayLogic {
    func displaySomething(viewModel: RandomImages.Something.ViewModel) {
        display(newState: viewModel.state)
    }

    func display(newState: RandomImages.ViewControllerState) {
        state = newState
        switch state {
        case .loading:
            print("loading...")
        case let .error(message):
            print("error \(message)")
        case let .result(items):
            print("result: \(items)")
        case .emptyResult:
            print("empty result")
        }
    }
}
