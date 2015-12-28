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

public final class PopCommentsTransistion: NSObject, UIViewControllerAnimatedTransitioning {
    
    let isInteractive: Bool
    
    init(isInteractive: Bool) {
        self.isInteractive = isInteractive
    }
    
    // MARK: UIViewControllerAnimatedTransitioning Methods
    
    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return animationDuration
    }
    
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let source = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? CommentsViewController,
                  sourceView = transitionContext.viewForKey(UITransitionContextFromViewKey),
                  destinationView = transitionContext.viewForKey(UITransitionContextToViewKey),
                  containerView = transitionContext.containerView()
        
        else { fatalError("Some Initial Conditions are missing") }
        
        containerView.addSubview(destinationView)
        containerView.addSubview(sourceView)
        containerView.backgroundColor = UIColor.darkGrayColor()
    
        destinationView.alpha = 0.9
        let opts : UIViewAnimationOptions = isInteractive ? .CurveLinear : .CurveEaseInOut

        UIView.animateWithDuration(animationDuration, delay: 0, options: opts, animations: { () -> Void in

            sourceView.frame = self.getFinalFrameForSourceView(containerView.bounds)
            destinationView.alpha = 1.0
            
            }) { (finished) -> Void in
                
                if transitionContext.transitionWasCancelled() {
                    containerView.backgroundColor = source.type.colors.NavBar
                }
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
    
    // MARK: - Utility Methods
    
    private func getFinalFrameForSourceView(initialFrame: CGRect) -> CGRect {
        var finalFrame = initialFrame
        finalFrame.origin.y = initialFrame.height
        finalFrame.size.height -= 20
        return finalFrame
    }
}
