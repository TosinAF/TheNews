//
//  PageViewController.swift
//  TheNews
//
//  Created by Tosin A on 11/3/15.
//  Copyright © 2015 Tosin Afolabi. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIGestureRecognizerDelegate {
    
    var svp: UIPanGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for view in self.view.subviews
        {
            if let scrollView = view as? UIScrollView
            {
                svp = UIPanGestureRecognizer()
                svp!.delegate = self;
                scrollView.addGestureRecognizer(svp!)

            }
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == svp! {
            
            let LIV = gestureRecognizer.locationInView(view)
            if LIV.x < 50.0 {
                return true
            }
        }
        return false
    }
}
