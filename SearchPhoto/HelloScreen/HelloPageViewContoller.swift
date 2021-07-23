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
            pages.append(vc)
        }
        setViewControllers([pages[0]], direction: .forward, animated: false, completion: nil)
    }
}

extension HelloPageViewContoller: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return pages.last }
        guard pages.count > previousIndex else { return nil }

        return pages[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else { return pages.first }
        guard pages.count > nextIndex else { return nil }

        return pages[nextIndex]
    }
}

extension HelloPageViewContoller: UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstVC = pageViewController.viewControllers?.first,
            let firstVCIndex = pages.firstIndex(of: firstVC) else { return 0 }

        return firstVCIndex
    }
}

class HomeScreenController: UIViewController {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        self.view.addSubview(imageView)
        self.view.addSubview(descriptionLabel)
    }
    
    private func makeConstraints() {
        let imageViewConstraints = [
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ]
        
        let descriptionLabelConstraints = [
            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(descriptionLabelConstraints)
    }
}

class PageLauncherController: UIViewController {
    let myContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()

    var thePageVC: HelloPageViewContoller!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myContainerView)
        NSLayoutConstraint.activate([
            myContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40.0),
            myContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40.0),
            myContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40.0),
            myContainerView.heightAnchor.constraint(equalToConstant: 200.0)
        ])

        thePageVC = HelloPageViewContoller()
        addChild(thePageVC)

        thePageVC.view.translatesAutoresizingMaskIntoConstraints = false
        myContainerView.addSubview(thePageVC.view)
        NSLayoutConstraint.activate([
            thePageVC.view.topAnchor.constraint(equalTo: myContainerView.topAnchor, constant: 0.0),
            thePageVC.view.bottomAnchor.constraint(equalTo: myContainerView.bottomAnchor, constant: 0.0),
            thePageVC.view.leadingAnchor.constraint(equalTo: myContainerView.leadingAnchor, constant: 0.0),
            thePageVC.view.trailingAnchor.constraint(equalTo: myContainerView.trailingAnchor, constant: 0.0),
        ])
        thePageVC.didMove(toParent: self)
    }
}
