//
//  PresentCommentsTransition.swift
//  TheNews
//
//  Created by Tosin Afolabi on 12/2/15.
//  Copyright © 2015 Tosin Afolabi. All rights reserved.
//

import UIKit

class PresentCommentsTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let animationDuration = 0.4
    let source: FeedViewController
    
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
        
        let snapshot = targetCell.takeSnapshot()
        let targetCellImageView = UIImageView(image: snapshot)
        targetCellImageView.frame = source.tableView.convertRect(targetCell.frame, toView: containerView)
        containerView.addSubview(targetCellImageView)
        
        var targetFrame = targetCellImageView.frame
        targetFrame.origin.y = 64.0
        
        // Prepare Destination View
        
        destination.navigationBar.alpha = 0.0
        destination.tableView.alpha = 0.0
        destination.tableHeaderView.alpha = 0.0
        
        UIView.animateWithDuration(0.2) { () -> Void in
            let _ = self.source.tableView.visibleCells.map({ $0.alpha = 0.0 })
        }
        
        delay(0.2) { () -> () in
            
            UIView.animateWithDuration(0.4, delay: 0.0, options: .CurveEaseIn, animations: { () -> Void in
                destination.navigationBar.alpha = 1.0
                destination.tableView.alpha = 1.0
                }, completion: nil)
        }
        
        UIView.animateWithDuration(animationDuration, animations: { () -> Void in
            
            targetCellImageView.frame = targetFrame
            destination.navigationBar.alpha = 1.0
            
            }) { (finished) -> Void in
                
                
                targetCellImageView.alpha = 0.0
                destination.tableHeaderView.alpha = 1.0
                transitionContext.completeTransition(true)
        }
    }
    
}

private extension UIView {
    
    func takeSnapshot() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.mainScreen().scale)
        drawViewHierarchyInRect(self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
