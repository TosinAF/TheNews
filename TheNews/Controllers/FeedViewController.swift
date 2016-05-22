//
//  ViewController.swift
//  TheNews
//
//  Created by Tosin Afolabi on 7/24/15.
//  Copyright © 2015 Tosin Afolabi. All rights reserved.
//

import UIKit
import Unbox
import SwiftyJSON
import Cartography
import JTHamburgerButton

class FeedViewController: UIViewController, Feed {
    
    let type: FeedType
    
    var posts = [Post]()
    
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
        
        setupConstriants()
        
        DesignerNewsProvider.request(.Stories) { (result) in
            switch result {
                
            case let .Success(moyaResponse):
                
                let data = moyaResponse.data
                let json = JSON(data: data)
            
                var posts = [Post]()
                for (_, story): (String, JSON) in json["stories"] {
                    let post = Post()
                    DataMapper.map(post, data: story)
                    posts.append(post)
                }
                
                self.posts = posts
                self.tableView.reloadData()
            
            case .Failure(let error):
                print(error)
                break
            }
        }
        
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
        return posts.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("feed", forIndexPath: indexPath) as! FeedTableViewCell
        
        let post = posts[indexPath.row]
        cell.titleLabel.text = post.title
        cell.detailLabel.text = "\(post.points) points by \(post.author)"
        cell.commentCount = post.commentCount
        
        cell.commentButtonClosure = { [unowned self] in
            self.navigationController?.pushViewController(CommentsViewController(type: self.type), animated: true)
        }
        
        return cell
    }
}
