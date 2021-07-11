//
//  PhotoViewerController.swift
//  SearchPhoto
//
//  Created by Fenix Lavon on 7/11/21.
//

import UIKit

protocol PhotoViewerControllerDelegate: AnyObject {
    
}

class PhotoViewerController: UIViewController {
    lazy var viewer = self.view as? PhotoViewerView
    let model: PhotoViewerModel
    
    override func loadView() {
        self.view = PhotoViewerView(model: model)
    }
    
    init(image: UIImageView, uid: String, name: String) {
        model = PhotoViewerModel(uid: uid, name: name, image: image)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotoViewerController: UIGestureRecognizerDelegate {
    
}

extension PhotoViewerController: PhotoViewerControllerDelegate {

}
