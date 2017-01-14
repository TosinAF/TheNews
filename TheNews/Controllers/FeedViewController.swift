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
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.separatorColor = ColorPalette.Grey.Light
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "feed")
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPosts()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feed", for: indexPath) as! FeedTableViewCell
        
        let post = viewModel.postAtIndex(indexPath.row)
        cell.titleLabel.text = post.title
        cell.detailLabel.text = post.detailText
        cell.commentCount = post.commentCount
        
        cell.commentButtonClosure = { [unowned self] in
            self.navigationController?.pushViewController(CommentsViewController(type: self.type, post: post), animated: true)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = viewModel.postAtIndex(indexPath.row)
        let url = URL(string: post.url)!
            
        let vc = SafariViewController(url: url)
        //vc.view.tintColor = type.colors.Brand
        vc.preferredBarTintColor = type.colors.Brand
        vc.preferredControlTintColor = UIColor.white
        present(vc, animated: true, completion: nil)

    }
}
