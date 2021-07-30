//
//  HelloPageViewContoller.swift
//  SearchPhoto
//
//  Created by Artur Lutfullin on 7/21/21.
//

import UIKit

final class HelloPageViewContoller: UIPageViewController {
	// MARK: - Properties
	private let size = CGSize(width: (UIScreen.main.bounds.width * 2) / 3, height: (UIScreen.main.bounds.height * 2) / 3)
    private var pages = [UIViewController]()
    private let images = [
		UIImage(named: "Favorite"),
		UIImage(named: "Random"),
		UIImage(named: "Searchs")
	]

	// MARK: - Init
    override init(transitionStyle style: UIPageViewController.TransitionStyle,
				  navigationOrientation: UIPageViewController.NavigationOrientation,
				  options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	// MARK: - View cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self

        for item in 0..<3 {
			let viewController = HomeScreenController(image: (images[item]?.resizeImage(targetSize: size))!)
			if item == 2 {
				viewController.isLast = true
			}
            pages.append(viewController)
        }
        setViewControllers([pages[0]], direction: .forward, animated: false, completion: nil)
    }
}

// MARK: - UIPageViewControllerDataSource
extension HelloPageViewContoller: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return pages[0] }
        guard pages.count > previousIndex else { return nil }

        return pages[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard pages.count > nextIndex else { return nil }
        return pages[nextIndex]
    }
}
