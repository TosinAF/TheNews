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

private let kNavigationBarHeight: CGFloat = 64.0

enum FeedType: Int {
    case PH = 0, DN, HN
}

protocol Feed {
 
    var type: FeedType { get }
    
}

class FeedViewController: UIViewController, Feed {
    
    let type: FeedType
    
    lazy var navigationBar: NavigationBar = {
        let navigationBar = NavigationBar(titles: ["TOP", "NEW", "SHOW", "ASK"])
        navigationBar.barTintColor = ColorPalette.HN.NavBar
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        return navigationBar
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layoutMargins = UIEdgeInsetsZero
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.separatorColor = ColorPalette.Grey.Light
        tableView.registerClass(FeedTableViewCell.self, forCellReuseIdentifier: "feed")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(type: FeedType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.addSubview(navigationBar)
        view.addSubview(tableView)
        
        configure()
        
        addConstriants()
    }
    
    func addConstriants() {
    
        layout(navigationBar) { navigationBar in
            navigationBar.top == navigationBar.superview!.top
            navigationBar.left == navigationBar.superview!.left
            navigationBar.width == navigationBar.superview!.width
            navigationBar.height == kNavigationBarHeight
        }
        
        layout(tableView) { tableView in
            tableView.edges == inset(tableView.superview!.edges, kNavigationBarHeight, 0, 0, 0)
        }
    }
    
    func configure() {
        
        switch (type) {
        case .PH:
            navigationBar.barTintColor = ColorPalette.PH.Brand
        case .DN:
            navigationBar.barTintColor = ColorPalette.DN.NavBar
        case .HN:
            navigationBar.barTintColor = ColorPalette.HN.NavBar
        }
    }
}

// MARK: - TableViewDataSource & Delegate Methods

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("feed", forIndexPath: indexPath) as! FeedTableViewCell
        
        if indexPath.row % 2 == 0 {
            cell.titleLabel.text = "Open-source Playstation 4 SDK"
        } else {
            cell.titleLabel.text = "Academics are being hoodwinked into writing books nobody can buy"
        }
        
        cell.detailLabel.text = "49 points by Andrew W."
        return cell
    }
}


