//
//  RandomImages module
//  Created by Artur Lutfullin on 17/07/2021.
//

import UIKit

protocol RandomImagesDisplayLogic: AnyObject {
    func displaySomething(viewModel: RandomImages.LoadImage.ViewModel)
}

protocol RandomImagesViewControllerDelegate: AnyObject {
    func openViewer(with model: PhotoViewerModel)
    func loadImages()
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
        self.view = RandomImagesView(frame: UIScreen.main.bounds, delegate: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        loadImages()
    }

    // MARK: - load Images

    private func setUpNavigationBar() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = .black
        navigationItem.title = "Random Images"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

extension RandomImagesViewController: RandomImagesDisplayLogic {
    func displaySomething(viewModel: RandomImages.LoadImage.ViewModel) {
        display(newState: viewModel.state)
    }

    func display(newState: RandomImages.ViewControllerState) {
        state = newState
        switch state {
        case .loading:
            print("loading...")
        case let .error(message):
			createActivity(message: message)
        case let .result(items):
            collectionDataSource.models = items
            collectionHandler.models = items
            collectionView?.delegate = self
            collectionHandler.delegate = self
            collectionView?.updateCollectioViewData(delegate: collectionHandler, dataSource: collectionDataSource)
        case .emptyResult:
			print("Empty result")
        }
	}

	private func createActivity(message: String) {
		let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"),
									  style: .default,
									  handler: { _ in NSLog("The \"OK\" alert occured.")}))
		self.present(alert, animated: true, completion: nil)
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

    func loadImages() {
        let request = RandomImages.LoadImage.Request()
        interactor.loadImages(request: request)
    }
}
