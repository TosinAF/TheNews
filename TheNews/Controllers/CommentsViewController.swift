//
//  CommentsViewController.swift
//  TheNews
//
//  Created by Tosin A on 11/20/15.
//  Copyright © 2015 Tosin Afolabi. All rights reserved.
//

import UIKit
import Cartography
import JTHamburgerButton

private let kCloseButtonSize: CGFloat = 40.0
private let kCloseButtonMargin: CGFloat = 20.0
private let kHeaderViewHeight: CGFloat = 100.0

class CommentsViewController: UIViewController {
    
    let type: FeedType
    let post: Post
    
    let comments = [Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph]

    lazy var headerView: FeedTableViewCell = {
        let headerView = FeedTableViewCell(style: .default, reuseIdentifier: "feed")
        headerView.titleLabel.text = self.post.title
        headerView.detailLabel.text = self.post.detailText
        headerView.borderView.alpha = 1.0
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        // FIXME: Calculate Row Height Manually
        tableView.estimatedRowHeight = 100
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.separatorColor = ColorPalette.Grey.Light
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: "comment")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var closeButton: JTHamburgerButton = {
        let button = JTHamburgerButton(frame: .zero)
        button.currentMode = .cross
        button.lineColor = .white
        button.backgroundColor = self.type.colors.Light
        button.layer.cornerRadius = kCloseButtonSize / 2
        button.configure(lineWidth: 25.0, lineHeight: 1.0, lineSpacing: 7.0)
        button.addTarget(self, action: #selector(CommentsViewController.dismiss as (CommentsViewController) -> () -> ()), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(type: FeedType, post: Post) {
        self.type = type
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white

        view.addSubview(headerView)
        view.addSubview(tableView)
        view.addSubview(closeButton)
        
        setupConstriants()

        if let navController = navigationController as? NavigationController {
            view.addGestureRecognizer(navController.panGesture)
        }
    }
    
    func setupConstriants() {
        
        constrain(headerView) { headerView in
            headerView.top == headerView.superview!.top
            headerView.left == headerView.superview!.left
            headerView.width == headerView.superview!.width
            headerView.height == kHeaderViewHeight
        }
        
        constrain(tableView) { tableView in
            tableView.edges == inset(tableView.superview!.edges, kHeaderViewHeight, 0, 0, 0)
        }
        
        constrain(closeButton) { closeButton in
            closeButton.left == closeButton.superview!.left + kCloseButtonMargin
            closeButton.bottom == closeButton.superview!.bottom - kCloseButtonMargin
            closeButton.width == kCloseButtonSize
            closeButton.height == kCloseButtonSize
        }
    }
    
    func dismiss() {
        
        if let navController = navigationController as? NavigationController {
            navController.setPopAnimationToNotInteractive()
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
}

// MARK: - TableViewDataSource & Delegate Methods

extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "comment", for: indexPath) as! CommentTableViewCell
        cell.textView.text = comments[indexPath.row]
        cell.authorTextView.textColor = self.type.colors.Light
        return cell
    }
}

// MARK: - UIScrollViewDelegate Methods

extension CommentsViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let isHidden = scrollView.panGestureRecognizer.translation(in: scrollView).y < 0
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.closeButton.alpha = isHidden ? 0.0 : 1.0
        })
    }
}
