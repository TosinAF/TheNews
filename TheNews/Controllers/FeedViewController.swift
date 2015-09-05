//
//  ViewController.swift
//  TheNews
//
//  Created by Tosin Afolabi on 7/24/15.
//  Copyright © 2015 Tosin Afolabi. All rights reserved.
//

import UIKit
import Cartography
import JTHamburgerButton

class FeedViewController: UIViewController {
    
    lazy var navigationBar: NavigationBar = {
        let navigationBar = NavigationBar(titles: ["TOP", "NEW", "SHOW", "ASK"])
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.barTintColor = ColorPalette.HN.NavBar
        return navigationBar
    }()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(navigationBar)
        addConstriants()
    }
    
    func addConstriants() {
    
        layout(navigationBar) { navigationBar in
            navigationBar.top == navigationBar.superview!.top
            navigationBar.left == navigationBar.superview!.left
            navigationBar.width == navigationBar.superview!.width
            navigationBar.height == 64.0
        }
    
    }
}

