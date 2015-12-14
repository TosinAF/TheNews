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
    
    // Intresting stuff about custom view controller transistion
    // http://stackoverflow.com/questions/24338700/from-view-controller-disappears-using-uiviewcontrollercontexttransitioning
    
    let targetFrame: CGRect
    let d: FeedViewController
    
    init(destination: FeedViewController, targetFrame: CGRect) {
        self.d = destination
        self.targetFrame = targetFrame
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return animationDuration
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning Methods
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let source = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? CommentsViewController
            else { fatalError("Wrong Destination View Controller Type used for Transistion") }
        
        guard let destination = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
            else { fatalError("Wrong Destination View Controller Type used for Transistion") }
        
        guard let containerView = transitionContext.containerView()
            else { fatalError("Container View Missing") }
        
        // Configure Container
        
        //containerView.addSubview(source.view)
        //containerView.addSubview(destination.view)
        
        // Create POP Animations
        
        let routeTranslateYAnim = POPBasicAnimation(propertyNamed: kPOPLayerTranslationY)
        routeTranslateYAnim.toValue = 30
        
        source.view.layer.pop_addAnimation(routeTranslateYAnim, forKey: "transform.translation.y")
        
        UIView.animateWithDuration(animationDuration, animations: { () -> Void in
            source.view.alpha = 0.0
            destination.view.alpha = 1.0
            }) { (finished) -> Void in
                transitionContext.completeTransition(true)
                UIApplication.sharedApplication().keyWindow!.addSubview(self.d.view)
        }
    }
}
