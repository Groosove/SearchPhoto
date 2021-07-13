//
//  PhotoViewerController.swift
//  SearchPhoto
//
//  Created by Fenix Lavon on 7/11/21.
//

import UIKit

protocol PhotoViewerControllerDelegate: AnyObject {
    func savePhoto(url: String)
    func parsePhoto(with imageId: String)
    func downloadPhoto(with image: UIImage)
}

class PhotoViewerController: UIViewController {
    lazy var viewer = self.view as? PhotoViewerView
    let model: PhotoViewerModel
    
    override func loadView() {
        self.view = PhotoViewerView(model: model)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewer?.delegate = self
        setUpNavigationBar()
    }
    
    init(with model: PhotoViewerModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpNavigationBar() {
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.title = model.name
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "cross"), style: .done, target: self, action: #selector(dismissController))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareImage))
    }
    
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

extension PhotoViewerController: UIGestureRecognizerDelegate {
    
}

extension PhotoViewerController: PhotoViewerControllerDelegate {

    
    func savePhoto(url: String) {
        
    }

    func parsePhoto(with imageId: String) {
        let httpHandler = HTTPHandler()
        let decoder: JSONDecoder = JSONDecoder()
        let parametrs = ["client_id": Unsplash.API.clientId]
        print(imageId)
        httpHandler.get(baseURL: Unsplash.baseURL, endPoint: "/photos/\(imageId)", parametrs: parametrs) { result in
            switch result {
            case let .success(data):
                do {
                    let models = try decoder.decode(PhotoStatModel.self, from: data)
                    print(models)
                }
                catch { print(PhotosCollectionServiceError.decodeJSON) }
            default : break
            }
        }
    }

    func downloadPhoto(with image: UIImage) {
        
    }
}
