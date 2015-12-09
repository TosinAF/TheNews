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
    var d: CommentsViewController!
    
    init(source: FeedViewController) {
        self.source = source
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return animationDuration
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning Methods
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let destination = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? CommentsViewController
            else { fatalError("Wrong Destination View Controller Type used for Transistion") }
        
        guard let containerView = transitionContext.containerView()
            else { fatalError("Container View Missing") }
        
        containerView.addSubview(source.view)
        containerView.addSubview(destination.view)
        
        // Take snapshot of Target Cell
    
        guard let targetCell = source.tableView.cellForRowAtIndexPath(source.targetCellIndexPath) as? FeedTableViewCell
            else { fatalError("Wrong Cell Class used for Transistion") }
        targetCell.borderView.alpha = 1.0
        
        let targetCellImageView = UIImageView(image: targetCell.takeSnapshot())
        targetCellImageView.frame = source.tableView.convertRect(targetCell.frame, toView: containerView)
        
        targetCell.borderView.alpha = 0.0
        
        containerView.addSubview(targetCellImageView)
        
        // Target Frame
        
        var targetFrame = targetCellImageView.frame
        targetFrame.origin.y = 64.0
        
        let targetFrameAnim = POPSpringAnimation(propertyNamed: kPOPViewFrame)
        targetFrameAnim.springBounciness = 3
        targetFrameAnim.springSpeed = 10
        targetFrameAnim.delegate = self
        targetFrameAnim.toValue = NSValue(CGRect: targetFrame)
        
        // Prepare Destination View
        
        destination.navigationBar.alpha = 0.0
        destination.closeButton.alpha = 0.0
        destination.tableView.alpha = 0.0
        destination.tableHeaderView.alpha = 0.0
        
        d = destination
        

        // Perform Animations
        // Animation Timings are weird, code isnt ideal but offers best experience
        
        UIView.animateWithDuration(0.2) { () -> Void in
            let _ = self.source.tableView.visibleCells.map({ $0.alpha = 0.0 })
        }
        
        targetCellImageView.pop_addAnimation(targetFrameAnim, forKey: "frame")
        
        UIView.animateWithDuration(animationDuration, animations: { () -> Void in
            
            destination.navigationBar.alpha = 1.0
            
            }) { (finished) -> Void in
                
                targetCellImageView.alpha = 0.0
                //destination.tableHeaderView.alpha = 1.0
                transitionContext.completeTransition(true)
        }
        
        delay(0.2) { () -> () in
            UIView.animateWithDuration(0.4, delay: 0.0, options: .CurveEaseIn, animations: { () -> Void in
                destination.navigationBar.alpha = 1.0
                //destination.tableView.alpha = 1.0
                }, completion: nil)
        }
        
        delay(0.6) { () -> () in
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                destination.closeButton.alpha = 1.0
            })
        }
    }
    
}

extension PresentCommentsTransition: POPAnimationDelegate {
    
    func pop_animationDidStop(anim: POPAnimation!, finished: Bool) {
        UIView.animateWithDuration(0.4, delay: 0.0, options: .CurveEaseIn, animations: { () -> Void in
            //destination.navigationBar.alpha = 1.0
            self.d!.tableView.alpha = 1.0
            }, completion: nil)
    }

}
