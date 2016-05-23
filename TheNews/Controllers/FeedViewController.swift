//
//  ViewController.swift
//  TheNews
//
//  Created by Tosin Afolabi on 7/24/15.
//  Copyright © 2015 Tosin Afolabi. All rights reserved.
//

import UIKit
import SwiftyJSON
import Cartography
import SafariServices
import JTHamburgerButton

class FeedViewController: UIViewController, Feed {
    
    let type: FeedType
    
    let viewModel: FeedViewModel
    
    lazy var navigationBar: NavigationBar = {
        let navigationBar = NavigationBar(titles: self.type.filters)
        navigationBar.barTintColor = self.type.colors.Brand
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
        self.viewModel = FeedViewModel(type: self.type)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.addSubview(navigationBar)
        view.addSubview(tableView)
        
        setupConstriants()
        
        viewModel.completionBlock = {
            self.tableView.reloadData()
        }
        
        viewModel.loadPosts()
    }
    
    func setupConstriants() {
    
        constrain(navigationBar) { navigationBar in
            navigationBar.top == navigationBar.superview!.top
            navigationBar.left == navigationBar.superview!.left
            navigationBar.width == navigationBar.superview!.width
            navigationBar.height == kNavigationBarHeight
        }
        
        constrain(tableView) { tableView in
            tableView.edges == inset(tableView.superview!.edges, kNavigationBarHeight, 0, 0, 0)
        }
    }
}

// MARK: - TableViewDataSource & Delegate Methods

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPosts()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("feed", forIndexPath: indexPath) as! FeedTableViewCell
        
        let post = viewModel.postAtIndex(indexPath.row)
        cell.titleLabel.text = post.title
        cell.detailLabel.text = post.detailText
        cell.commentCount = post.commentCount
        
        cell.commentButtonClosure = { [unowned self] in
            self.navigationController?.pushViewController(CommentsViewController(type: self.type, post: post), animated: true)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let post = viewModel.postAtIndex(indexPath.row)
        let url = NSURL(string: post.url)!
        
        if #available(iOS 9.0, *) {
            
            let vc = SafariViewController(URL: url)
            vc.delegate = self
            vc.view.tintColor = type.colors.Brand
            navigationController?.pushViewController(vc, animated: true)
            
        } else {
            
            let vc = WebViewController(URL: url)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

@available(iOS 9.0, *)
extension FeedViewController: SFSafariViewControllerDelegate {

    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        navigationController?.popViewControllerAnimated(true)
    }
}