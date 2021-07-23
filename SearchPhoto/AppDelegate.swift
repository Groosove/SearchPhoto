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
    var isFirstLaunch = UserDefaults.standard.bool(forKey: "isFirstLaunch")
	func application(_ application: UIApplication, didFinishLaunchingWithOptions
						launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let stack = Container.shared.coreDataStack
        stack.load()
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = MainTabBarController()
        if isFirstLaunch {
            window?.rootViewController = MainTabBarController()
        } else {
            window?.rootViewController = PageLauncherController()
            UserDefaults.standard.set(true, forKey: "isFirstLaunch")
        }
		window?.makeKeyAndVisible()
		return true
	}
}
