//
//  PhotoViewerController.swift
//  SearchPhoto
//
//  Created by Artur Lutfullin on 14.07.21.
//

import UIKit
import CoreData

protocol PhotoViewerControllerDelegate: AnyObject {

	func savePhoto(with image: UIImage, model: PhotoViewerModel)
	func unsavePhoto(uid: String)
	func parsePhoto(with imageId: String)
	func downloadPhoto(with image: UIImage)
	func getImage(with imageURL: String) -> Bool
}

final class PhotoViewerController: UIViewController, UINavigationControllerDelegate {

	// MARK: - Properties
    let imageData = StackContainer.shared.coreDataStack
    private let frc: NSFetchedResultsController<Images> = {
           let request = NSFetchRequest<Images>(entityName: "Images")
           request.sortDescriptors = [.init(key: "imageURL", ascending: true)]
           return NSFetchedResultsController(fetchRequest: request,
                                         managedObjectContext: StackContainer.shared.coreDataStack.viewContext,
                                         sectionNameKeyPath: nil,
                                         cacheName: nil)
    }()
	lazy var viewer = self.view as? PhotoViewerView
	let model: PhotoViewerModel
	private let transition = PanelTransition()
	private var firstTouch: CGPoint = .zero
	private var lastTouch: CGPoint = .zero

	// MARK: - View cycle

	override func loadView() {
//		super.loadView()
		self.view = PhotoViewerView(model: model)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		viewer?.delegate = self
		let image = (getImage(with: model.uid)) ? UIImage(named: "like") : UIImage(named: "unlike")
		viewer?.likeButton.setImage(image, for: .normal)
		setUpNavigationBar()
		addGesture()
	}

	override func viewDidLayoutSubviews() {
		viewer?.scrollView.setZoomScale()
	}

	// MARK: - Init
	init(with model: PhotoViewerModel) {
		self.model = model
		super.init(nibName: nil, bundle: nil)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Setup NavigationBar
	private func setUpNavigationBar() {
		navigationController?.navigationBar.barTintColor = .black
		navigationController?.navigationBar.tintColor = .white
		navigationItem.hidesSearchBarWhenScrolling = true
		navigationItem.title = model.name
		navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
		navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "cross"),
														   style: .done,
														   target: self,
														   action: #selector(dismissController))
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareImage))
	}

	// MARK: - Private functions
	@objc private func dismissController() {
		dismiss(animated: true, completion: nil)
	}

	@objc private func shareImage() {
		let imageToShare = [model.image.image!]
		let activityVC = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
		activityVC.popoverPresentationController?.sourceView = self.view
		activityVC.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
		self.present(activityVC, animated: true, completion: nil)
	}

	private func documentDirectoryPath() -> URL? {
		let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return path.first
	}

	private func addGesture() {
		let singleTap = UITapGestureRecognizer(target: self, action: #selector(didSingleTap(_:)))
		singleTap.numberOfTapsRequired = 1
		singleTap.numberOfTouchesRequired = 1
		viewer?.scrollView.addGestureRecognizer(singleTap)

		let doubleTap = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap(_:)))
		doubleTap.numberOfTapsRequired = 2
		doubleTap.numberOfTouchesRequired = 1
		singleTap.require(toFail: doubleTap)
		viewer?.scrollView.addGestureRecognizer(doubleTap)

		let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
		panGesture.cancelsTouchesInView = false
		panGesture.delegate = self
		viewer?.scrollView.addGestureRecognizer(panGesture)
	}
}

// MARK: - PhotoViewerControllerDelegate
extension PhotoViewerController: PhotoViewerControllerDelegate {

	func unsavePhoto(uid: String) {
		imageData.unlikeImages(uid: uid)
	}

	func savePhoto(with image: UIImage, model: PhotoViewerModel) {
		if let pngData = image.pngData(), let path = documentDirectoryPath()?.appendingPathComponent(model.uid) {
			try? pngData.write(to: path)
		}

		imageData.viewContext.performAndWait {
			let imagePath = Images(context: imageData.viewContext)
			imagePath.uid = model.uid
			imagePath.height = Double(model.height)
			imagePath.width = Double(model.width)
			imagePath.imageURL = model.imageURL
			imagePath.name = model.name
			try? imageData.viewContext.save()
		}
		try? frc.performFetch()
	}

	func parsePhoto(with imageId: String) {
		let httpHandler = HTTPHandler()
		let decoder = JSONDecoder()
		let parametrs = ["client_id": Unsplash.API.clientId]
		httpHandler.get(baseURL: Unsplash.baseURL, endPoint: "/photos/\(imageId)", parametrs: parametrs) { result in
			do {
				let data = try result.get()
				let model = try decoder.decode(PhotoStatModel.self, from: data)
				self.descriptionCreate(with: model)
			} catch { createActivity(with: self, message: "Check your internet connection") }
		}
	}

	func downloadPhoto(with image: UIImage) {
		UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
	}

	func getImage(with imageURL: String) -> Bool {
//		return true
		return imageData.getImage(uid: imageURL)
	}
}

// MARK: - UIPopoverPresentationControllerDelegate
extension PhotoViewerController: UIPopoverPresentationControllerDelegate {
	private func descriptionCreate(with model: PhotoStatModel) {
		let rootVC = DescriptionViewController(model: model)
		rootVC.transitioningDelegate = transition
		rootVC.modalPresentationStyle = .custom
		present(rootVC, animated: true)
	}
}

// MARK: - UIGestureRecognizerDelegate
extension PhotoViewerController: UIGestureRecognizerDelegate {
	@objc private func didSingleTap(_ recognizer: UITapGestureRecognizer) {
		guard let view = viewer else { return }
		let currentNavAlpha = self.navigationController?.navigationBar.alpha ?? 0.0
		UIView.animate(withDuration: 0.235) {
			self.navigationController?.navigationBar.alpha = currentNavAlpha > 0.5 ? 0.0 : 1.0
			view.infoViewButton.alpha = currentNavAlpha > 0.5 ? 0.0 : 1.0
			view.likeButton.alpha = currentNavAlpha > 0.5 ? 0.0 : 1.0
			view.downloadButton.alpha = currentNavAlpha > 0.5 ? 0.0 : 1.0
		}
	}

	@objc private func didDoubleTap(_ recognizer: UITapGestureRecognizer) {
		let pointInView = recognizer.location(in: viewer?.scrollView)
		viewer?.scrollView.zoomInOrOut(at: pointInView)
	}

	@objc private func didPan(_ recognizer: UIPanGestureRecognizer) {
		guard let scroll = viewer?.scrollView else { return }
		guard scroll.zoomScale == scroll.minimumZoomScale else { return }
		if recognizer.state == .began {
			firstTouch = recognizer.translation(in: view)
		}

		if recognizer.state != .cancelled {
			lastTouch = recognizer.translation(in: view)
		}

		if recognizer.state == .ended {
			if lastTouch.y - firstTouch.y > (scroll.imageView.frame.height / 4) {
				dismissController()
			}
		}
	}

	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
						   shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
		return true
	}
}
