//
//  DismissCommentsTransistion.swift
//  TheNews
//
//  Created by Tosin Afolabi on 12/9/15.
//  Copyright © 2015 Tosin Afolabi. All rights reserved.
//

import pop
import UIKit

private let animationDuration = 0.4

class DismissCommentsTransistion: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return animationDuration
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning Methods
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let source = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? CommentsViewController,
                  destination = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
                  containerView = transitionContext.containerView()
        
        else { fatalError("Some Initial Conditions are missing") }
        
        containerView.addSubview(source.view)
        containerView.addSubview(destination.view)
        
        // Initial Contions
        destination.view.alpha = 0.8
        containerView.backgroundColor = UIColor.darkGrayColor()
        
        var finalFrame = containerView.bounds
        finalFrame.origin.y = containerView.bounds.height
        
        // Create POP Animations
        let frameAnim = POPSpringAnimation(propertyNamed: kPOPViewFrame)
        frameAnim.springBounciness = 1
        frameAnim.springSpeed = 15
        frameAnim.toValue = NSValue(CGRect: finalFrame)
        
        source.view.pop_addAnimation(frameAnim, forKey: "view.frame")
        
        UIView.animateWithDuration(animationDuration, animations: { () -> Void in

            source.view.alpha = 0.0
            destination.view.alpha = 1.8
            
            }) { (finished) -> Void in
                
                transitionContext.completeTransition(true)
                UIApplication.sharedApplication().keyWindow!.addSubview(destination.view)
        }
    }
}
