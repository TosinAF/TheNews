//
//  NavigationController.swift
//  TheNews
//
//  Created by Tosin Afolabi on 12/16/15.
//  Copyright © 2015 Tosin Afolabi. All rights reserved.
//

import UIKit

private let kInteractiveAnimationThreshold: CGFloat = 0.5

public class NavigationController: UINavigationController {
    
    private var popAnimationIsInteractive = true
    private var interactivePopTransition: UIPercentDrivenInteractiveTransition?
    
    lazy var panGesture: UIPanGestureRecognizer = {
        let panGesture = UIPanGestureRecognizer(target: self, action: "handlePan:")
        return panGesture
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    // MARK: Gesture Recognizer Actions
    
    public func handlePan(recognizer: UIPanGestureRecognizer) {
        
        guard let recognizerView = recognizer.view
            else { fatalError("Gesture Recognizer should have a view") }
        
        let progress = recognizer.translationInView(recognizerView).y / CGRectGetHeight(recognizerView.bounds)
        
        switch (recognizer.state) {
            
        case .Began:
            popAnimationIsInteractive = true
            interactivePopTransition = UIPercentDrivenInteractiveTransition()
            self.popViewControllerAnimated(true)
            
        case .Changed:
            interactivePopTransition?.updateInteractiveTransition(progress)
            
        case .Ended:
            if progress > kInteractiveAnimationThreshold {
                interactivePopTransition?.finishInteractiveTransition()
            } else {
                interactivePopTransition?.cancelInteractiveTransition()
            }
            interactivePopTransition = nil
            
        default:
            interactivePopTransition?.cancelInteractiveTransition()
        }
    }
    
    // MARK: Utility Methods
    
    func setPopAnimationToNotInteractive() {
        popAnimationIsInteractive = false
    }
}

// MARK: UINavigationControllerDelegate

extension NavigationController: UINavigationControllerDelegate {
    
    public func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation,
        fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            
            if (operation == .Push) {
                return PushCommentsTransition()
            } else {
                return PopCommentsTransistion(isInteractive: popAnimationIsInteractive)
            }
    }
    
    public func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return interactivePopTransition
    }
}