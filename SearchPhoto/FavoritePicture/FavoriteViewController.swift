//
//  FavoriteViewController.swift
//  SearchPhoto
//
//  Created by Artur Lutfullin on 04.07.21.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {
    var collectionView: UICollectionView?
    var images = [UIImage?]()
    var models = [Images]()
    let imageData = Container.shared.setModel(with: "Images").coreDataStack
    private let frc: NSFetchedResultsController<Images> = {
           let request = NSFetchRequest<Images>(entityName: "Images")
           request.sortDescriptors = [.init(key: "imageURL", ascending: true)]
           return NSFetchedResultsController(fetchRequest: request,
                                         managedObjectContext: Container.shared.coreDataStack.viewContext,
                                         sectionNameKeyPath: nil,
                                         cacheName: nil)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        images = getImages()
        models = imageData.getAllImages()
        setUpNavigationBar()
        setUpCollectionView()
    }
    

    private func setUpNavigationBar() {
        navigationController?.navigationBar.barTintColor = .black
        navigationItem.title = "Favorite Photos"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
    private func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView?.register(FavoriteViewCell.self, forCellWithReuseIdentifier: FavoriteViewCell.identifier)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        self.view.addSubview(collectionView ?? UICollectionView())
    }
        
    private func getImages() -> [UIImage?] {
        let imagePaths = imageData.getAllImages()
        imagePaths.forEach { print($0.imageURL) }
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let dirPath = paths.first {
            var result = [UIImage?]()
            for item in imagePaths {
                let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(item.uid)
                let image = UIImage(contentsOfFile: imageURL.path)
                result.append(image)
            }
            return result
        }
        return []
    }
    
    private func openViewer(with model: PhotoViewerModel) {
        let rootVC = PhotoViewerController(with: model)
        let navVC = CustomNavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        navigationController?.modalPresentationStyle = .fullScreen
        self.navigationController?.present(navVC, animated: true)
    }
}

extension FavoriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteViewCell.identifier, for: indexPath)
        guard let imagePhoto = cell as? FavoriteViewCell else { return UICollectionViewCell() }
        imagePhoto.configure(image: images[indexPath.item])
        return imagePhoto
    }
}

extension FavoriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let item = models[indexPath.item]
        guard images[indexPath.item] != nil else { return }
        let image = UIImageView(image: images[indexPath.item])
        let result = PhotoViewerModel(uid: item.uid, name: item.name, image: image, width: CGFloat(item.width), height: CGFloat(item.height), imageURL: item.imageURL)
        openViewer(with: result)
     }
}
