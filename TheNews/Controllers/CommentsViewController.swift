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
    
    let comments = [Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph, Lorem.paragraph]
    
    lazy var headerView: FeedTableViewCell = {
        let headerView = FeedTableViewCell(style: .Default, reuseIdentifier: "feed")
        headerView.titleLabel.text = "Academics are being hoodwinked into writing books nobody can buy"
        headerView.detailLabel.text = "49 points by Andrew W."
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
        tableView.layoutMargins = UIEdgeInsetsZero
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.separatorColor = ColorPalette.Grey.Light
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.registerClass(CommentTableViewCell.self, forCellReuseIdentifier: "comment")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var closeButton: JTHamburgerButton = {
        let button = JTHamburgerButton(frame: .zero)
        button.currentMode = .Cross
        button.lineColor = .whiteColor()
        button.backgroundColor = ColorPalette.DN.Light
        button.layer.cornerRadius = kCloseButtonSize / 2
        button.configure(lineWidth: 25.0, lineHeight: 1.0, lineSpacing: 7.0)
        button.addTarget(self, action: "dismiss", forControlEvents: .TouchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.view.addSubview(headerView)
        self.view.addSubview(tableView)
        self.view.addSubview(closeButton)
        
        setupConstriants()
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
        dismissViewControllerAnimated(true, completion: nil)
    }
}

// MARK: - TableViewDataSource & Delegate Methods

extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("comment", forIndexPath: indexPath) as! CommentTableViewCell
        cell.textView.text = comments[indexPath.row]
        return cell
    }
}

// MARK: - UIScrollViewDelegate Methods

extension CommentsViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let isHidden = scrollView.panGestureRecognizer.translationInView(scrollView).y < 0
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.closeButton.alpha = isHidden ? 0.0 : 1.0
        })
    }
}
