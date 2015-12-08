//
//  PageViewController.swift
//  TheNews
//
//  Created by Tosin A on 11/3/15.
//  Copyright © 2015 Tosin Afolabi. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    lazy var panGestureRecognzier: UIPanGestureRecognizer = {
        let panGestureRecognzier = UIPanGestureRecognizer()
        panGestureRecognzier.delegate = self;
        return panGestureRecognzier
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        for view in self.view.subviews {
            if let scrollView = view as? UIScrollView {
                scrollView.addGestureRecognizer(panGestureRecognzier)
            }
        }
    }
}

extension PageViewController: UIGestureRecognizerDelegate {

    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if gestureRecognizer == panGestureRecognzier {
            let locationInView = gestureRecognizer.locationInView(view)
            if  locationInView.y > 64.0 { return true }
        }
        
        return false
    }
}
