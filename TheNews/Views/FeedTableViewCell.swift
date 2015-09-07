//
//  FeedViewCell.swift
//  TheNews
//
//  Created by Tosin Afolabi on 9/5/15.
//  Copyright © 2015 Tosin Afolabi. All rights reserved.
//

import UIKit
import TZStackView
import Cartography

private let kVerticalSpacing = 5.0
private let kContentInset = 20.0
private let kLeftMargin = 13.0

class FeedTableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .blackColor()
        label.font = UIFont(name: "Montserrat", size: 15.0)
        return label
    }()
    
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.Grey.Normal
        label.font = UIFont(name: "Montserrat", size: 12.0)
        return label
    }()
    
    lazy var commentsButton: CommentButton = {
        let button = CommentButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 2.0
        return button
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutMargins = UIEdgeInsetsZero
        selectionStyle = .None
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        
        let stackView2 = TZStackView(arrangedSubviews: [detailLabel, commentsButton])
        stackView2.distribution = .Fill
        stackView2.alignment = .Center
        stackView2.axis = .Horizontal
        stackView2.spacing = 0.0
        
        let stackView = TZStackView(arrangedSubviews: [titleLabel, stackView2])
        stackView.distribution = .Fill
        stackView.alignment = .Top
        stackView.axis = .Vertical
        stackView.spacing = 8.0
        
        contentView.addSubview(stackView)
        
        layout(stackView, contentView) { stackView, contentView in
            stackView.left == stackView.superview!.left + 13
            stackView.right == stackView.superview!.right - 12
            stackView.centerY == stackView.superview!.centerY
        }
    }
}

class CommentButton: UIButton {

    lazy var count: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.839, green: 0.447, blue: 0.290, alpha: 1.0)
        label.text = "13 Comments"
        label.font = UIFont(name: "Montserrat", size: 12.0)
        return label
    }()
    
    lazy var icon: UIImageView = { 
        let image = UIImage(named: "chat")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRectZero)
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        let stackView = TZStackView(arrangedSubviews: [count, icon])
        stackView.distribution = .Fill
        stackView.alignment = .Center
        stackView.axis = .Horizontal
        stackView.spacing = 5.0
        
        addSubview(stackView)
        
        icon.hidden = true
        
        layout(stackView) { stackView in
            stackView.left == stackView.superview!.left
            stackView.right == stackView.superview!.right
            stackView.top == stackView.superview!.top
            stackView.bottom == stackView.superview!.bottom
        }
    }
    
    override func intrinsicContentSize() -> CGSize {
        return CGSizeMake(30,15)
    }
}
