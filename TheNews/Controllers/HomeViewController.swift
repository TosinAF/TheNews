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
        .ph: FeedViewController(type: .ph),
        .dn: FeedViewController(type: .dn),
        .hn: FeedViewController(type: .hn)
    ]
    
    var currentFeedType: FeedType = .dn
    
    // MARK: Views
    
    lazy var pageViewController: UIPageViewController = {
        guard let initialVC = self.vcs[.dn]
            else { fatalError("View Controllers have not been properly configured ") }
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        pageViewController.view.backgroundColor = ColorPalette.Grey.Light
        pageViewController.setViewControllers([initialVC], direction: .forward, animated: false, completion: nil)
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        return pageViewController
    }()
    
    // MARK: View Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        edgesForExtendedLayout = UIRectEdge()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()

        pageViewController.didMove(toParentViewController: self)
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
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let vc = viewController as? Feed
            else { fatalError("Topmost VC does not conform to Feed Protocol") }
        
        switch (vc.type) {
        case .ph:
            return nil
        case .dn:
            return vcs[.ph]
        case .hn:
            return vcs[.dn]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vc = viewController as? Feed
            else { fatalError("Topmost VC does not conform to Feed Protocol") }
        
        switch (vc.type) {
        case .ph:
            return vcs[.dn]
        case .dn:
            return vcs[.hn]
        case .hn:
            return nil
        }
    }
}

