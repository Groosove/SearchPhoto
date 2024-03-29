//
//  PanelTransition.swift
//  SearchPhoto
//
//  Created by Artur Lutfullin on 14.07.2021.
//

import UIKit

final class PanelTransition: NSObject, UIViewControllerTransitioningDelegate {

	// MARK: - Presentation controller
	private let driver = TransitionDriver()

	func presentationController(forPresented presented: UIViewController,
								presenting: UIViewController?,
								source: UIViewController) -> UIPresentationController? {
		driver.link(to: presented)

		let presentationController = DimmPresentationController(presentedViewController: presented,
																presenting: presenting ?? source)
		presentationController.driver = driver
		return presentationController
	}

	// MARK: - Animation
	func animationController(forPresented presented: UIViewController,
							 presenting: UIViewController,
							 source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return PresentAnimation()
	}

	func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return DismissAnimation()
	}

	// MARK: - Interaction

	func interactionControllerForPresentation(
		using animator: UIViewControllerAnimatedTransitioning
	) -> UIViewControllerInteractiveTransitioning? {
		return driver
	}

	func interactionControllerForDismissal(
		using animator: UIViewControllerAnimatedTransitioning
	) -> UIViewControllerInteractiveTransitioning? {
		return driver
	}
}
