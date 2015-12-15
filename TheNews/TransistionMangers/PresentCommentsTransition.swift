//
//  PresentCommentsTransition.swift
//  TheNews
//
//  Created by Tosin Afolabi on 12/2/15.
//  Copyright © 2015 Tosin Afolabi. All rights reserved.
//

import pop
import UIKit

private let animationDuration = 0.4

class PresentCommentsTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    // MARK: - UIViewControllerAnimatedTransitioning Methods
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let containerView = transitionContext.containerView(),
              let source = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
              let destination = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        else { fatalError("Some Initial Conditions are missing") }
        
        containerView.addSubview(source.view)
        containerView.addSubview(destination.view)
        
        // Initial Contions
        var initialFrame = containerView.bounds
        initialFrame.origin.y = containerView.bounds.height
        initialFrame.size.height -= 20
        
        var finalFrame = initialFrame
        finalFrame.origin.y = 20
        
        destination.view.frame = initialFrame
        destination.view.alpha = 0.0
        
        // Create POP Animation
        let frameAnim = POPSpringAnimation(propertyNamed: kPOPViewFrame)
        frameAnim.springBounciness = 1
        frameAnim.springSpeed = 15
        frameAnim.toValue = NSValue(CGRect: finalFrame)
        
        // Round Top Corners
        let cornerRadii = CGSizeMake(7.0, 7.0)
        let maskPath = UIBezierPath(roundedRect: destination.view.bounds, byRoundingCorners: [.TopLeft, .TopRight], cornerRadii: cornerRadii)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = containerView.bounds
        maskLayer.path = maskPath.CGPath
        
        destination.view.layer.pop_addAnimation(frameAnim, forKey: "view.frame")
        
        UIView.animateWithDuration(animationDuration, animations: { () -> Void in
            destination.view.alpha = 1.0
            destination.view.layer.mask = maskLayer
            
            }) { (finished) -> Void in
                transitionContext.completeTransition(true)
        }
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return animationDuration
    }
}
