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

final class FeedTableViewCell: UITableViewCell {
    
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
        button.layer.cornerRadius = 2.0
        button.backgroundColor = UIColor(red:0.969, green:0.969, blue:0.969, alpha: 1.0)
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
        
        let infoStackView = TZStackView(arrangedSubviews: [titleLabel, detailLabel])
        infoStackView.configure(distributon: .Fill, alignment: .Top, axis: .Vertical, spacing: 8.0)
        
        let stackView = TZStackView(arrangedSubviews: [infoStackView, commentsButton])
        stackView.configure(distributon: .Fill, alignment: .Center, axis: .Horizontal, spacing: 0.0)
        
        contentView.addSubview(stackView)
        
        layout(stackView) { stackView in
            stackView.left == stackView.superview!.left + 15
            stackView.right == stackView.superview!.right - 15
            stackView.centerY == stackView.superview!.centerY
        }
    }
}

