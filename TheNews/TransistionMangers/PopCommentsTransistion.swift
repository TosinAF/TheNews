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
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let source = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? CommentsViewController,
                  let sourceView = transitionContext.view(forKey: UITransitionContextViewKey.from),
                  let destinationView = transitionContext.view(forKey: UITransitionContextViewKey.to)

        else { fatalError("Some Initial Conditions are missing") }

        let containerView = transitionContext.containerView
        
        containerView.addSubview(destinationView)
        containerView.addSubview(sourceView)
        containerView.backgroundColor = UIColor.darkGray
    
        destinationView.alpha = 0.9
        let opts : UIViewAnimationOptions = isInteractive ? .curveLinear : UIViewAnimationOptions()

        UIView.animate(withDuration: animationDuration, delay: 0, options: opts, animations: { () -> Void in

            sourceView.frame = self.getFinalFrameForSourceView(containerView.bounds)
            destinationView.alpha = 1.0
            
            }) { (finished) -> Void in
                
                if transitionContext.transitionWasCancelled {
                    containerView.backgroundColor = source.type.colors.NavBar
                }
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    // MARK: - Utility Methods
    
    fileprivate func getFinalFrameForSourceView(_ initialFrame: CGRect) -> CGRect {
        var finalFrame = initialFrame
        finalFrame.origin.y = initialFrame.height
        finalFrame.size.height -= 20
        return finalFrame
    }
}
