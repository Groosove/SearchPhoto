//
//  TransitionDriver.swift
//  SearchPhoto
//
//  Created by Artur Lutfullin on 14.07.2021.
//

import UIKit

enum TransitionDirection {
    case present, dismiss
}

final class TransitionDriver: UIPercentDrivenInteractiveTransition {

    // MARK: - Linking
    func link(to controller: UIViewController) {
        presentedController = controller
        panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handle(recognizer:)))
        presentedController?.view.addGestureRecognizer(panRecognizer!)
    }

    private weak var presentedController: UIViewController?
    private var panRecognizer: UIPanGestureRecognizer?

    // MARK: - Override
    override var wantsInteractiveStart: Bool {
        get {
            switch direction {
            case .present:
                return false
            case .dismiss:
                let gestureIsActive = panRecognizer?.state == .began
                return gestureIsActive
            }
        }
		// swiftlint:disable unused_setter_value
        set { }
		// swiftlint:enable unused_setter_value
    }

    // MARK: - Direction
    var direction: TransitionDirection = .present

    @objc private func handle(recognizer: UIPanGestureRecognizer) {
        switch direction {
        case .present:
            handlePresentation(recognizer: recognizer)
        case .dismiss:
            handleDismiss(recognizer: recognizer)
        }
    }
}

// MARK: - Gesture Handling
extension TransitionDriver {

    private func handlePresentation(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            pause()
        case .changed:
            let increment = -recognizer.incrementToBottom(maxTranslation: maxTranslation)
            update(percentComplete + increment)

        case .ended, .cancelled:
            if recognizer.isProjectedToDownHalf(maxTranslation: maxTranslation) {
                cancel()
            } else {
                finish()
            }

        case .failed:
            cancel()

        default:
            break
        }
    }

    private func handleDismiss(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            pause()

            if !isRunning {
                presentedController?.dismiss(animated: true)
            }

        case .changed:
            update(percentComplete + recognizer.incrementToBottom(maxTranslation: maxTranslation))

        case .ended, .cancelled:
            if recognizer.isProjectedToDownHalf(maxTranslation: maxTranslation) {
                finish()
            } else {
                cancel()
            }

        case .failed:
            cancel()

        default:
            break
        }
    }

    var maxTranslation: CGFloat {
        return presentedController?.view.frame.height ?? 0
    }

    private var isRunning: Bool {
        return percentComplete != 0
    }
}

private extension UIPanGestureRecognizer {
    func isProjectedToDownHalf(maxTranslation: CGFloat) -> Bool {
        let endLocation = projectedLocation(decelerationRate: .fast)
        let isPresentationCompleted = endLocation.y > maxTranslation / 2

        return isPresentationCompleted
    }

    func incrementToBottom(maxTranslation: CGFloat) -> CGFloat {
        let translation = self.translation(in: view).y
        setTranslation(.zero, in: nil)

        let percentIncrement = translation / maxTranslation
        return percentIncrement
    }
}
