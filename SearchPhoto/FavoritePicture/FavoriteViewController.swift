//
//  FavoriteViewController.swift
//  SearchPhoto
//
//  Created by Artur Lutfullin on 04.07.21.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {
    // MARK: - Properties
    private var collectionView: UICollectionView?
	private var images = [(image: UIImage?, cropImage: UIImage?)]()
    private var models = [Images]()
    private let imageData = Container.shared.coreDataStack
    private let frc: NSFetchedResultsController<Images> = {
           let request = NSFetchRequest<Images>(entityName: "Images")
           request.sortDescriptors = [.init(key: "imageURL", ascending: true)]
           return NSFetchedResultsController(fetchRequest: request,
                                         managedObjectContext: Container.shared.coreDataStack.viewContext,
                                         sectionNameKeyPath: nil,
                                         cacheName: nil)
    }()

    // MARK: - View cycle
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		images = getImages()
		models = imageData.getAllImages()
		setUpNavigationBar()
		setUpCollectionView()
	}

    // MARK: - Setup UI
    private func setUpNavigationBar() {
        navigationController?.navigationBar.barTintColor = .black
        navigationItem.title = "Favorite Photos"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

    private func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView?.register(FavoriteViewCell.self, forCellWithReuseIdentifier: FavoriteViewCell.identifier)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        self.view.addSubview(collectionView ?? UICollectionView())
    }

    // MARK: - Private Function
    private func getImages() -> [(UIImage?, UIImage?)] {
        let imagePaths = imageData.getAllImages()
		guard imagePaths.count != images.count else { return images }
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)

        if let dirPath = paths.first {
            var result = [(UIImage?, UIImage?)]()
            for item in imagePaths {
                let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(item.uid)
                let imageFromFile = UIImage(contentsOfFile: imageURL.path)
				guard let image = imageFromFile else { continue }
				let cropImage = image.cropImage(targetSize: CGSize(width: self.view.frame.width/3, height: self.view.frame.width/3))
                result.append((image, cropImage))
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

// MARK: - UICollectionViewDataSource
extension FavoriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteViewCell.identifier, for: indexPath)
        guard let imagePhoto = cell as? FavoriteViewCell else { return UICollectionViewCell() }
		imagePhoto.configure(image: images[indexPath.item].cropImage)
        return imagePhoto
    }
}

// MARK: - UICollectionViewDelegate
extension FavoriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let item = models[indexPath.item]
		guard images[indexPath.item].image != nil else { return }
		let image = UIImageView(image: images[indexPath.item].image)
        let result = PhotoViewerModel(uid: item.uid,
									  name: item.name,
									  image: image,
									  width: CGFloat(item.width),
									  height: CGFloat(item.height),
									  imageURL: item.imageURL)
        openViewer(with: result)
     }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
		layout?.sectionInset = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
		layout?.minimumInteritemSpacing = 3
		layout?.minimumLineSpacing = 3
		layout?.invalidateLayout()

		return CGSize(width: (self.view.frame.width/3) - 4, height: (self.view.frame.width / 3) - 4)
	}
}
