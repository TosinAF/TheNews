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
    
    let source: FeedViewController
    
    init(source: FeedViewController) {
        self.source = source
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning Methods
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let destination = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? CommentsViewController
            else { fatalError("Wrong Destination View Controller Type used for Transistion") }
        
        guard let containerView = transitionContext.containerView()
            else { fatalError("Container View Missing") }
        
        // Configure Container
        containerView.addSubview(source.view)
        containerView.addSubview(destination.view)
        
        // Set Initial Contions
        
        var frame = containerView.bounds
        frame.origin.y += containerView.bounds.height
        frame.size.height -= 20
        destination.view.frame = frame
        destination.view.alpha = 0.0
        
        // Create POP Animation
        
        let routeTranslateYAnim = POPSpringAnimation(propertyNamed: kPOPLayerTranslationY)
        routeTranslateYAnim.springBounciness = 1
        routeTranslateYAnim.springSpeed = 15
        routeTranslateYAnim.toValue = -(containerView.bounds.height - 20)
        
        // Round Top Corners
        
        let cornerRadii = CGSizeMake(7.0, 7.0)
        let maskPath = UIBezierPath(roundedRect: destination.view.bounds, byRoundingCorners: [.TopLeft, .TopRight], cornerRadii: cornerRadii)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = containerView.bounds
        maskLayer.path = maskPath.CGPath
        
        destination.view.layer.pop_addAnimation(routeTranslateYAnim, forKey: "transform.translation.y")
        
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
