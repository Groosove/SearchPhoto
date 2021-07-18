//
//  PhotoViewerController.swift
//  SearchPhoto
//
//  Created by Artur Lutfullin on 14.07.21.
//

import UIKit
import CoreData

protocol PhotoViewerControllerDelegate: AnyObject {
    func savePhoto(url: String)
    func unsavePhoto(url: String)
    func parsePhoto(with imageId: String)
    func downloadPhoto(with image: UIImage, imageURL: String)
    func getImage(with imageURL: String) -> Bool
}

class PhotoViewerController: UIViewController, UINavigationControllerDelegate {
    let imageData = Container.shared.setModel(with: "Images").coreDataStack
    private let frc: NSFetchedResultsController<Images> = {
           let request = NSFetchRequest<Images>(entityName: "Images")
           request.sortDescriptors = [.init(key: "imageURL", ascending: true)]
           return NSFetchedResultsController(fetchRequest: request,
                                         managedObjectContext: Container.shared.coreDataStack.viewContext,
                                         sectionNameKeyPath: nil,
                                         cacheName: nil)
    }()

    lazy var viewer = self.view as? PhotoViewerView
    let model: PhotoViewerModel
	private let transition = PanelTransition()
	
    override func loadView() {
		super.loadView()
        self.view = PhotoViewerView(model: model)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewer?.delegate = self
        let image = (getImage(with: model.imageURL)) ? UIImage(named: "like") : UIImage(named: "unlike")
        viewer?.likeButton.setImage(image, for: .normal)
        setUpNavigationBar()
    }
    
    init(with model: PhotoViewerModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -- Setup NavigationBar
    private func setUpNavigationBar() {
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.title = model.name
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "cross"), style: .done, target: self, action: #selector(dismissController))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareImage))
    }
    
	// MARK: -- Dissmiss Controller
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
	
}

extension PhotoViewerController: PhotoViewerControllerDelegate {
    func unsavePhoto(url: String) {
        imageData.unlikeImages(imageURL: url + ".png")
    }

    func savePhoto(url: String) {
        imageData.viewContext.performAndWait {
            let imagePath = Images(context: imageData.viewContext)
            imagePath.imageURL = url + ".png"
            try? imageData.viewContext.save()
        }
        try? frc.performFetch()
    }

    func parsePhoto(with imageId: String) {
        let httpHandler = HTTPHandler()
        let decoder: JSONDecoder = JSONDecoder()
        let parametrs = ["client_id": Unsplash.API.clientId]
        httpHandler.get(baseURL: Unsplash.baseURL, endPoint: "/photos/\(imageId)", parametrs: parametrs) { result in
			do {
				let data = try result.get()
				let model = try decoder.decode(PhotoStatModel.self, from: data)
				self.descriptionCreate(with: model)
			}
			catch { print(PhotosCollectionServiceError.decodeJSON) }
        }
    }
    
    func downloadPhoto(with image: UIImage, imageURL: String) {
        if let pngData = image.pngData(), let path = documentDirectoryPath()?.appendingPathComponent(imageURL + ".png") {
            try? pngData.write(to: path)
        }
    }
    
    private func documentDirectoryPath() -> URL? {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path.first
    }
    
    func getImage(with imageURL: String) -> Bool {
        return imageData.getImage(imageURL: imageURL + ".png")
    }
}

extension PhotoViewerController: UIPopoverPresentationControllerDelegate {
	private func descriptionCreate(with model: PhotoStatModel) {
		let rootVC = DescriptionViewController(model: model)
		rootVC.transitioningDelegate = transition
		rootVC.modalPresentationStyle = .custom
		present(rootVC, animated: true)
	}
}
