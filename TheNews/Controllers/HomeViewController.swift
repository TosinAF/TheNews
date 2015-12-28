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
    
    let vcs: [FeedType: UIViewController] = [
        .PH: FeedViewController(type: .PH),
        .DN: FeedViewController(type: .DN),
        .HN: FeedViewController(type: .HN)
    ]
    
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
        
        setupConstraints()
    }
    
    // MARK: Layout
    
    func setupConstraints() {
    
        constrain(pageViewController.view) { pageView in
            pageView.edges == pageView.superview!.edges
        }
    }
}

// MARK: - UIPageViewController DataSource & Delegate

extension HomeViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        guard let vc = viewController as? Feed
            else { fatalError("Topmost VC does not conform to Feed Protocol") }
        
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
        
        guard let vc = viewController as? Feed
            else { fatalError("Topmost VC does not conform to Feed Protocol") }
        
        switch (vc.type) {
        case .PH:
            return vcs[.DN]
        case .DN:
            return vcs[.HN]
        case .HN:
            return nil
        }
    }
}

