//
//  MainTabBarController.swift
//  SearchPhoto
//
//  Created by Артур Лутфуллин on 04.07.21.
//

import UIKit

final class CustomNavigationController: UINavigationController {
	override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
}

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        view.backgroundColor = .black
        tabBar.barTintColor = .black
		tabBar.tintColor = .white

		let searchPhotoViewController = generateNavigationController(with: PhotosCollectionBuilder().set(state: .loading).build(), imageName: "search")
        let favoritePictures = generateNavigationController(with: FavoriteViewController(), imageName: "heart")
        let randomImages = generateNavigationController(with: RandomImagesBuilder().set(initialState: .loading).build(), imageName: "picture")

        viewControllers = [randomImages, searchPhotoViewController, favoritePictures]
		tabBar.items?.forEach { $0.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0); $0.title = "" }
    }

	private func generateNavigationController(with controller: UIViewController, imageName: String) -> UIViewController {
		let navigationVC = CustomNavigationController(rootViewController: controller)
		navigationVC.tabBarItem.image = UIImage(named: imageName)
		return navigationVC
	}
}

func createActivity(with vc: UIViewController, message: String) {
	let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
	alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"),
								  style: .default,
								  handler: { _ in NSLog("The \"OK\" alert occured.")}))
	vc.present(alert, animated: true, completion: nil)
}
