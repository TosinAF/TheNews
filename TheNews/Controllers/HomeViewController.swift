//
//  HomeViewController.swift
//  TheNews
//
//  Created by Tosin A on 11/3/15.
//  Copyright © 2015 Tosin Afolabi. All rights reserved.
//

import UIKit
import Cartography

class HomeViewController: UIViewController {
    
    let vcs = [FeedViewController(type: .PH), FeedViewController(type: .DN), FeedViewController(type: .HN)]
    
    lazy var pageViewController: PageViewController = {
        let pageViewController = PageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        pageViewController.view.backgroundColor = UIColor.whiteColor()
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        return pageViewController
    }()
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        edgesForExtendedLayout = .None
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()

        pageViewController.didMoveToParentViewController(self)
        addChildViewController(pageViewController)
        view.addSubview(pageViewController.view)
        
        layout(pageViewController.view) { pageView in
            pageView.edges == pageView.superview!.edges
        }
        
        view.layoutIfNeeded()
        
        let initialVC = vcs[1]
        initialVC.view.frame = pageViewController.view.frame
        pageViewController.setViewControllers([initialVC], direction:  UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
    
    }
}

// MARK: - UIPageViewController DataSource & Delegate

extension HomeViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! Feed
        
        switch (vc.type) {
        case .HN:
            return vcs[1]
        case .DN:
            return vcs[0]
        case.PH:
            return nil
        }
        
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! Feed
        
        switch (vc.type) {
        case .HN:
            return nil
        case .DN:
            return vcs[2]
        case.PH:
            return vcs[1]
        }
    }
}

