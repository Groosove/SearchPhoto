//
//  PageLauncherController.swift
//  SearchPhoto
//
//  Created by Artur Lutfullin on 7/24/21.
//

import UIKit

final class PageLauncherController: UIViewController {
	//MARK: - Properties
    let myContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    var thePageVC = HelloPageViewContoller()

	//MARK: - View cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        makeConstraints()
        addChild(thePageVC)
        thePageVC.didMove(toParent: self)
    }

	//MARK: - Setup UI
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

