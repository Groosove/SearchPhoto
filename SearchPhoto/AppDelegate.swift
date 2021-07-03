//
//  AppDelegate.swift
//  SearchPhoto
//
//  Created by Артур Лутфуллин on 02.07.2021.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions
						launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		window = UIWindow(frame: UIScreen.main.bounds)
		let rootVC = PhotosCollectionBuilder().set(initialState: .loading).build()
		window?.rootViewController = rootVC
		window?.makeKeyAndVisible()
		return true
	}
}
