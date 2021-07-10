//
//  AppDelegate.swift
//  SearchPhoto
//
//  Created by Артур Лутфуллин on 02.07.2021.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions
						launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let stack = Container.shared.coreDataStack
        stack.load()
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = MainTabBarController()
		window?.makeKeyAndVisible()
		return true
	}
}
