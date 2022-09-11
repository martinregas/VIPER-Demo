//
//  FadeCollectionView.swift
//  VIPER-Demo
//
//  Created by Martin Regas on 07/09/2022.
//

import UIKit

class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    let durationExpanding = 0.75
    let durationClosing = 0.5
    var presenting = true
    var originFrame = CGRect.zero
    
    var dismissCompletion: (()->Void)?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return presenting ? durationExpanding : durationClosing
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if presenting {
            guard let toView = transitionContext.view(forKey: .to) else { return }
            expand(view: toView, using: transitionContext)
        } else {
            guard let fromView = transitionContext.view(forKey: .from) else { return }
            close(view: fromView, using: transitionContext)
        }
    }
    
    private func expand(view: UIView, using transitionContext: UIViewControllerContextTransitioning) {
        transitionContext.containerView.addSubview(view)
        transitionContext.containerView.bringSubviewToFront(view)
        
        let initialFrame = originFrame
        let finalFrame = view.frame
        
        let xScaleFactor = originFrame.width / finalFrame.width
        let yScaleFactor = originFrame.height / finalFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        view.transform = scaleTransform
        view.center = CGPoint( x: initialFrame.midX, y: initialFrame.midY)
        view.clipsToBounds = true
        
        UIView.animate(withDuration: durationExpanding, delay:0.0,
                       usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0,
                       animations: {
            view.transform = CGAffineTransform.identity
            view.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        },
                       completion:{_ in
            transitionContext.completeTransition(true)
        })
    }
    
    private func close(view: UIView, using transitionContext: UIViewControllerContextTransitioning) {
        transitionContext.containerView.addSubview(view)
        transitionContext.containerView.bringSubviewToFront(view)
        
        let xScaleFactor = originFrame.width / view.frame.width
        let yScaleFactor = originFrame.height / view.frame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        UIView.animate(withDuration: durationClosing, delay:0.0, options: .curveLinear,
                       animations: {
            view.transform = scaleTransform
            view.center = CGPoint(x: self.originFrame.midX, y: self.originFrame.midY)
        },
                       completion:{_ in
            if !self.presenting {
                self.dismissCompletion?()
            }
            transitionContext.completeTransition(true)
        })
    }
}
