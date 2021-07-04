//
//  MainTabBarController.swift
//  SearchPhoto
//
//  Created by Fenix Lavon on 7/4/21.
//

import UIKit

class CustomNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
}

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        view.backgroundColor = .black
        self.delegate = self
        tabBar.barTintColor = .black
        let searchPhotoViewController = PhotosCollectionBuilder().set(initialState: .loading).build()
        let favoritePictures = FavoriteViewController()
        let randomImages = RandomImagesViewController()
        searchPhotoViewController.tabBarItem.image = UIImage(named: "search")
        favoritePictures.tabBarItem.image = UIImage(named: "heart")
        randomImages.tabBarItem.image = UIImage(named: "picture")
        randomImages.tabBarItem.selectedImage?.withTintColor(.white)
        viewControllers = [
            randomImages, searchPhotoViewController, favoritePictures
        ]
        
        for item in tabBar.items! {
            item.title = ""
            item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
}

