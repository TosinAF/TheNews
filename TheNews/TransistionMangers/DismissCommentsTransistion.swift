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
    
    let targetFrame: CGRect
    let destination: FeedViewController
    
    init(destination: FeedViewController, targetFrame: CGRect) {
        self.destination = destination
        self.targetFrame = targetFrame
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return animationDuration
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning Methods
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let source = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? CommentsViewController
            else { fatalError("Wrong Destination View Controller Type used for Transistion") }
        
       /* guard let destination = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
            else { fatalError("Wrong Destination View Controller Type used for Transistion") }*/
        
        guard let containerView = transitionContext.containerView()
            else { fatalError("Container View Missing") }
        
        containerView.addSubview(source.view)
        containerView.addSubview(destination.view)
        
        source.tableHeaderView.borderView.alpha = 0.0
        
        var initialFrame = source.tableHeaderView.frame
        initialFrame.origin.y = 64
        
        let targetCellImageView = UIImageView(image: source.tableHeaderView.takeSnapshot())
        targetCellImageView.frame = initialFrame
        containerView.addSubview(targetCellImageView)
        
        delay(0.2) {
            UIView.animateWithDuration(0.2) { () -> Void in
                let _ = self.destination.tableView.visibleCells.map({ $0.alpha = 1.0 })
                            }
        }
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            
            source.view.alpha = 0.0
            self.destination.view.alpha = 1.0
            
            //source.tableHeaderView.alpha = 0.0
            
            targetCellImageView.frame = self.targetFrame
            targetCellImageView.alpha = 0.0
            
            
            
            
            
            }) { (finished) -> Void in
                
                targetCellImageView.alpha = 0.0
                transitionContext.completeTransition(true)
                UIApplication.sharedApplication().keyWindow!.addSubview(self.destination.view)
        }
        
        
    
    }
}
