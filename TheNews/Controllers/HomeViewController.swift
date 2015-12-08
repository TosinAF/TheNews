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
    
    // MARK: Properties
    
    let vcs: [FeedType: UIViewController] = [.PH : FeedViewController(type: .PH), .DN: FeedViewController(type: .DN), .HN: FeedViewController(type: .HN)]
    
    var currentFeedType: FeedType = .DN
    
    // MARK: Views
    
    lazy var pageViewController: UIPageViewController = {
        guard let initialVC = self.vcs[.DN]
            else { fatalError("View Controllers have not been properly configured ") }
        let pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        pageViewController.view.backgroundColor = ColorPalette.Grey.Light
        pageViewController.setViewControllers([initialVC], direction: .Forward, animated: false, completion: nil)
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        return pageViewController
    }()
    
    lazy var quickSwitcherView: QuickSwitcherView = {
        let quickSwitcherView = QuickSwitcherView(feedTypes: [.PH, .DN, .HN])
        quickSwitcherView.selectionClosure = { type in
            
            var direction: UIPageViewControllerNavigationDirection = .Forward
            if type.rawValue < self.currentFeedType.rawValue {
                direction = .Reverse
            }
            
            guard let vc = self.vcs[type]
                else { fatalError("View Controllers have not been properly configured ") }
            
            self.pageViewController.setViewControllers([vc], direction: direction, animated: true, completion: nil)
            self.currentFeedType = type
        }
        quickSwitcherView.layer.cornerRadius = 5.0
        quickSwitcherView.translatesAutoresizingMaskIntoConstraints = false
        return quickSwitcherView
    }()
    
    // MARK: View Lifecycle
    
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
        
        view.addSubview(quickSwitcherView)
        
        setupConstraints()
    }
    
    // MARK: Layout
    
    func setupConstraints() {
    
        constrain(pageViewController.view) { pageView in
            pageView.edges == pageView.superview!.edges
        }
        
        constrain(quickSwitcherView) { feedPickerView in
            feedPickerView.centerX == feedPickerView.superview!.centerX
            feedPickerView.bottom == feedPickerView.superview!.bottom - 20
        }
    }
}

// MARK: - UIPageViewController DataSource & Delegate

extension HomeViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! Feed
        
        switch (vc.type) {
        case .PH:
            return nil
        case .DN:
            return vcs[.PH]
        case .HN:
            return vcs[.DN]
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! Feed
        
        switch (vc.type) {
        case .PH:
            return vcs[.DN]
        case .DN:
            return vcs[.HN]
        case .HN:
            return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {

        let vc = pendingViewControllers.first as! Feed
        currentFeedType = vc.type
    }
}

