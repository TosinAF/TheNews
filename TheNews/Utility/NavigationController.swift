//
//  NavigationController.swift
//  TheNews
//
//  Created by Tosin Afolabi on 12/16/15.
//  Copyright © 2015 Tosin Afolabi. All rights reserved.
//

import UIKit

private let kInteractiveAnimationThreshold: CGFloat = 0.5

open class NavigationController: UINavigationController {
    
    fileprivate var popAnimationIsInteractive = true
    fileprivate var interactivePopTransition: UIPercentDrivenInteractiveTransition?
    
    let panGesture: UIPanGestureRecognizer = {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(NavigationController.handlePan(_:)))
        return panGesture
    }()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    // MARK: Gesture Recognizer Actions
    
    open func handlePan(_ recognizer: UIPanGestureRecognizer) {
        
        guard let recognizerView = recognizer.view
            else { fatalError("Gesture Recognizer should have a view") }
        
        let progress = recognizer.translation(in: recognizerView).y / recognizerView.bounds.height
        
        switch recognizer.state {
            
        case .began:
            popAnimationIsInteractive = true
            interactivePopTransition = UIPercentDrivenInteractiveTransition()
            self.popViewController(animated: true)
            
        case .changed:
            interactivePopTransition?.update(progress)
            
        case .ended:
            if progress > kInteractiveAnimationThreshold {
                interactivePopTransition?.finish()
            } else {
                interactivePopTransition?.cancel()
            }
            interactivePopTransition = nil
            
        default:
            interactivePopTransition?.cancel()
        }
    }
    
    // MARK: Utility Methods
    
    func setPopAnimationToNotInteractive() {
        popAnimationIsInteractive = false
    }
}

// MARK: UINavigationControllerDelegate

extension NavigationController: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation,
        from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        

        if type(of: fromVC) === SafariViewController.self || type(of: toVC) === SafariViewController.self {
            return nil
        }

            
        if (operation == .push) {
            return PushCommentsTransition()
        } else {
            return PopCommentsTransistion(isInteractive: popAnimationIsInteractive)
        }
    }
    
    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return interactivePopTransition
    }
}
