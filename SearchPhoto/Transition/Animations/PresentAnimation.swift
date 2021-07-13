//
//  PresentAnimation.swift
//  SearchPhoto
//
//  Created by Artur Lutfullin on 14.07.2021.
//

import UIKit

class PresentAnimation: NSObject {
    let duration: TimeInterval = 0.6

    private func animator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        let to = transitionContext.view(forKey: .to)!
        let finalFrame = transitionContext.finalFrame(for: transitionContext.viewController(forKey: .to)!)
        
        to.frame = finalFrame.offsetBy(dx: 0, dy: finalFrame.height)
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeOut) {
            to.frame = finalFrame
        }
        
        animator.addCompletion { (position) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        return animator
    }
}

extension PresentAnimation: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animator = self.animator(using: transitionContext)
        animator.startAnimation()
    }
    
    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        return self.animator(using: transitionContext)
    }
}

// MARK: - iOS 9
//extension PresentAnimation {
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        let to = transitionContext.view(forKey: .to)!
//        let finalFrame = transitionContext.finalFrame(for: transitionContext.viewController(forKey: .to)!)
//
//        to.frame = finalFrame.offsetBy(dx: 0, dy: finalFrame.height)
//
//        UIView.animate(withDuration: duration, delay: 0,
//                       usingSpringWithDamping: 1, initialSpringVelocity: 0,
//                       options: [.curveEaseOut], animations: {
//                        to.frame = finalFrame
//        }) { (_) in
//            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//        }
//    }
//}
