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
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let source = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
              let destination = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? CommentsViewController
        
        else { fatalError("Some Initial Conditions are missing") }

        let containerView = transitionContext.containerView
        
        containerView.addSubview(source.view)
        containerView.addSubview(destination.view)
        containerView.backgroundColor = destination.type.colors.NavBar
        
        let (initialDestinationFrame, finalDestinationFrame) = getFramesForDestinationView(containerView.bounds)
        
        destination.view.frame = initialDestinationFrame
        destination.view.alpha = 0.0
        
        let destinationFrameAnim = getDestinationFrameAnim(finalDestinationFrame)
        destination.view.layer.pop_add(destinationFrameAnim, forKey: "view.frame")
        
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            destination.view.alpha = 1.0
            destination.view.layer.mask = self.getMaskLayer(destination.view)
            
            }, completion: { (finished) -> Void in
                transitionContext.completeTransition(true)
        }) 
    }
    
    // MARK: Utility Methods
    
    fileprivate func getDestinationFrameAnim(_ frame: CGRect) -> POPSpringAnimation {
        
        let frameAnim = POPSpringAnimation(propertyNamed: kPOPViewFrame)
        frameAnim?.springBounciness = 1
        frameAnim?.springSpeed = 15
        frameAnim?.toValue = NSValue(cgRect: frame)
        return frameAnim!
    }
    
    fileprivate func getFramesForDestinationView(_ startingFrame: CGRect) -> (CGRect, CGRect) {
    
        var initialFrame = startingFrame
        initialFrame.origin.y = startingFrame.height
        initialFrame.size.height -= 20
        
        var finalFrame = initialFrame
        finalFrame.origin.y = 20
        
        return (initialFrame, finalFrame)
    }
    
    fileprivate func getMaskLayer(_ view: UIView) -> CAShapeLayer {
        
        // Round Top Corners
        let cornerRadii = CGSize(width: 7.0, height: 7.0)
        let maskPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: cornerRadii)
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds
        maskLayer.path = maskPath.cgPath
        return maskLayer
    }
}
