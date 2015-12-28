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

class PushCommentsTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    // MARK: UIViewControllerAnimatedTransitioning Methods
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return animationDuration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let containerView = transitionContext.containerView(),
              let source = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
              let destination = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? CommentsViewController
        
        else { fatalError("Some Initial Conditions are missing") }
        
        containerView.addSubview(source.view)
        containerView.addSubview(destination.view)
        containerView.backgroundColor = destination.type.colors.NavBar
        
        let (initialDestinationFrame, finalDestinationFrame) = getFramesForDestinationView(containerView.bounds)
        
        destination.view.frame = initialDestinationFrame
        destination.view.alpha = 0.0
        
        let destinationFrameAnim = getDestinationFrameAnim(finalDestinationFrame)
        destination.view.layer.pop_addAnimation(destinationFrameAnim, forKey: "view.frame")
        
        UIView.animateWithDuration(animationDuration, animations: { () -> Void in
            destination.view.alpha = 1.0
            destination.view.layer.mask = self.getMaskLayer(destination.view)
            
            }) { (finished) -> Void in
                transitionContext.completeTransition(true)
        }
    }
    
    // MARK: Utility Methods
    
    private func getDestinationFrameAnim(frame: CGRect) -> POPSpringAnimation {
        
        let frameAnim = POPSpringAnimation(propertyNamed: kPOPViewFrame)
        frameAnim.springBounciness = 1
        frameAnim.springSpeed = 15
        frameAnim.toValue = NSValue(CGRect: frame)
        return frameAnim
    }
    
    private func getFramesForDestinationView(startingFrame: CGRect) -> (CGRect, CGRect) {
    
        var initialFrame = startingFrame
        initialFrame.origin.y = startingFrame.height
        initialFrame.size.height -= 20
        
        var finalFrame = initialFrame
        finalFrame.origin.y = 20
        
        return (initialFrame, finalFrame)
    }
    
    private func getMaskLayer(view: UIView) -> CAShapeLayer {
        
        // Round Top Corners
        let cornerRadii = CGSizeMake(7.0, 7.0)
        let maskPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.TopLeft, .TopRight], cornerRadii: cornerRadii)
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds
        maskLayer.path = maskPath.CGPath
        return maskLayer
    }
}
