//
//  RandomImages module
//  Created by Artur Lutfullin on 17/07/2021.
//

import UIKit

protocol RandomImagesDisplayLogic: class {
    func displaySomething(viewModel: RandomImages.Something.ViewModel)
}

protocol RandomImagesViewControllerDelegate: AnyObject {
    func openViewer(with model: PhotoViewerModel)
}

class RandomImagesViewController: UIViewController {
    let interactor: RandomImagesBusinessLogic
    var state: RandomImages.ViewControllerState
    var collectionDataSource =  RandomImagesDataStore()
    var collectionHandler = RandomImagesWaterfallDelegate()
    lazy var collectionView = self.view as? RandomImagesView
    
    init(interactor: RandomImagesBusinessLogic, initialState: RandomImages.ViewControllerState = .loading) {
        self.interactor = interactor
        self.state = initialState
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = RandomImagesView(frame: UIScreen.main.bounds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadImages()
    }

    // MARK: -- load Images
    func loadImages() {
        let request = RandomImages.Something.Request()
        interactor.loadImages(request: request)
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
            collectionDataSource.models = items
            collectionHandler.models = items
            collectionView?.delegate = self
            collectionView?.updateCollectioViewData(delegate: collectionHandler, dataSource: collectionDataSource)
        case .emptyResult:
            print("empty result")
        }
    }
}

extension RandomImagesViewController: WaterfallLayoutDelegate {
    func waterfallLayout(_ layout: WaterfallLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let images = collectionDataSource.models[indexPath.item]
        return CGSize(width: images.width, height: images.height)
    }
}

extension RandomImagesViewController: RandomImagesViewControllerDelegate {
    func openViewer(with model: PhotoViewerModel) {
        let rootVC = PhotoViewerController(with: model)
        let navVC = CustomNavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        navigationController?.modalPresentationStyle = .fullScreen
        self.navigationController?.present(navVC, animated: true)
    }
}
