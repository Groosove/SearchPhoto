//
//  RandomImagesViewController.swift
//	SearchPhoto
//
//	Created by Artur Lutfullin on 17/07/2021.
//

import UIKit

protocol RandomImagesDisplayLogic: AnyObject {
    func displayImages(viewModel: RandomImages.LoadImage.ViewModel)
}

protocol RandomImagesViewControllerDelegate: AnyObject {
    func openViewer(with model: PhotoViewerModel)
    func loadImages()
}

final class RandomImagesViewController: UIViewController {
    // MARK: - Properties
    private let interactor: RandomImagesBusinessLogic
    private var state: RandomImages.ViewControllerState
    private let collectionDataSource =  RandomImagesDataStore()
    private let collectionHandler = RandomImagesDelegate()
    private lazy var collectionView = self.view as? RandomImagesView
	private let indicatorView = IndicatorView(frame: UIScreen.main.bounds)
    // MARK: - Init
    init(interactor: RandomImagesBusinessLogic, initialState: RandomImages.ViewControllerState = .loading) {
        self.interactor = interactor
        self.state = initialState
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View cycle
    override func loadView() {
        self.view = RandomImagesView(frame: UIScreen.main.bounds, delegate: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        loadImages()
    }

    // MARK: - Setup UI
    private func setUpNavigationBar() {
        navigationController?.navigationBar.barTintColor = .black
        navigationItem.title = "Random Images"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadImages))
		navigationItem.rightBarButtonItem?.tintColor = .white
    }

	// MARK: - Private functions
	@objc private func reloadImages() {
		collectionHandler.models = []
		collectionDataSource.models = []
		collectionView?.updateCollectioViewData(delegate: collectionHandler, dataSource: collectionDataSource)
		display(newState: .loading)
	}
}

// MARK: - RandomImagesDisplayLogic
extension RandomImagesViewController: RandomImagesDisplayLogic {
    func displayImages(viewModel: RandomImages.LoadImage.ViewModel) {
        display(newState: viewModel.state)
    }

    func display(newState: RandomImages.ViewControllerState) {
        state = newState
		switch state {
		case .loading:
			view.addSubview(indicatorView)
			indicatorView.isLoading = true
		default:
			indicatorView.isLoading = false
			indicatorView.removeFromSuperview()
		}

        switch state {
        case .loading:
			loadImages()
        case let .error(message):
			createActivity(with: self, message: message)
			indicatorView.isLoading = false
			indicatorView.removeFromSuperview()
        case let .result(items):
            collectionDataSource.models += items
            collectionHandler.models += items
            collectionHandler.delegate = self
			collectionView?.delegate = self
            collectionView?.updateCollectioViewData(delegate: collectionHandler, dataSource: collectionDataSource)

        case .emptyResult:
			createActivity(with: self, message: "Nothing was found for this result")
			indicatorView.isLoading = false
			indicatorView.removeFromSuperview()
        }
	}
}

// MARK: - WaterfallLayoutDelegate
extension RandomImagesViewController: WaterfallLayoutDelegate {
    func waterfallLayout(_ layout: WaterfallLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let images = collectionDataSource.models[indexPath.item]
        return CGSize(width: images.width, height: images.height)
    }
}

// MARK: - RandomImagesViewControllerDelegate
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
