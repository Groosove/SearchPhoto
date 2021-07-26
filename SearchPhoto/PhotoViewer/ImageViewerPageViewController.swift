//
//  ImageViewerPageViewController.swift
//  SearchPhoto
//
//  Created by Fenix Lavon on 7/26/21.
//

import UIKit

final class ImageViewerPageViewController: UIPageViewController {
    var pages = [UIViewController]()
    var models = [PhotoViewerModel]()
    var index: Int
    
    //MARK: - Init
    init(model: [Images] = [], index: Int) {
        self.index = index
        for item in model {
            let image = UIImageView()
            image.loadImage(imageURL: item.imageURL)
            models.append(PhotoViewerModel(uid: item.uid, name: item.name,
                                           image: image,
                                           width: CGFloat(item.width),
                                           height: CGFloat(item.height),
                                           imageURL: item.imageURL))
        }
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [:])
    }
    
    init(model: [PhotosCollectionViewModel] = [], index: Int) {
        self.index = index
        for item in model {
            let image = UIImageView()
            image.loadImage(imageURL: item.imageURL)
            models.append(PhotoViewerModel(uid: item.uid, name: item.name,
                                           image: image,
                                           width: item.width,
                                           height: item.height,
                                           imageURL: item.imageURL))
        }
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [:])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - View cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        for item in models {
            let vc = PhotoViewerController(with: item)
            pages.append(vc)
        }
        
        setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
    }
}
