//
//  HelloPageViewContoller.swift
//  SearchPhoto
//
//  Created by Artur Lutfullin on 7/21/21.
//

import UIKit

class HelloPageViewContoller: UIPageViewController {
    var pages = [UIViewController]()
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = nil

        for i in 0..<3 {
            let vc = HomeScreenController()
			if i == 2 {
				vc.isLast = true
			}
            pages.append(vc)
        }
        setViewControllers([pages[0]], direction: .forward, animated: false, completion: nil)
    }
}

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

class HomeScreenController: UIViewController {
	var isLast = false
    let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let descriptionLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
	let dismissButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Done", for: .normal)
		button.setTitleColor(.systemBlue, for: .normal)
		button.addTarget(self, action: #selector(dismissScreen), for: .touchUpInside)
		button.isHidden = true
		return button
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
		if isLast {
			dismissButton.isHidden = false
		}
        makeConstraints()
    }
    
    private func addSubviews() {
        self.view.addSubview(imageView)
        self.view.addSubview(descriptionLabel)
		self.view.addSubview(dismissButton)
    }
    
    private func makeConstraints() {
        let imageViewConstraints = [
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ]

        let descriptionLabelConstraints = [
            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor)
        ]

		let dismissButtonConstraints = [
			dismissButton.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor, constant: 10),
			dismissButton.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 10)
		]
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(descriptionLabelConstraints)
		NSLayoutConstraint.activate(dismissButtonConstraints)
    }

	@objc private func dismissScreen() {
		let rootVC = MainTabBarController()
		rootVC.modalPresentationStyle = .fullScreen
		present(rootVC, animated: true, completion: nil)
	}
}

class PageLauncherController: UIViewController {
    let myContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .white
        return view
    }()
    var thePageVC = HelloPageViewContoller()

    override func viewDidLoad() {
        super.viewDidLoad()
		addSubviews()
		makeConstraints()
        addChild(thePageVC)
        thePageVC.didMove(toParent: self)
    }

	private func addSubviews() {
		view.addSubview(myContainerView)
		myContainerView.addSubview(thePageVC.view)
	}

	private func makeConstraints() {
		thePageVC.view.translatesAutoresizingMaskIntoConstraints = false
		let myContainerViewConstraints = [
			myContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			myContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			myContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			myContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		]
		let thePageVCConstraints = [
			thePageVC.view.topAnchor.constraint(equalTo: myContainerView.topAnchor),
			thePageVC.view.bottomAnchor.constraint(equalTo: myContainerView.bottomAnchor),
			thePageVC.view.leadingAnchor.constraint(equalTo: myContainerView.leadingAnchor),
			thePageVC.view.trailingAnchor.constraint(equalTo: myContainerView.trailingAnchor)
		]
		
		NSLayoutConstraint.activate(thePageVCConstraints)
		NSLayoutConstraint.activate(myContainerViewConstraints)
	}
}
