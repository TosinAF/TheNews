//
//  FeedViewCell.swift
//  TheNews
//
//  Created by Tosin Afolabi on 9/5/15.
//  Copyright © 2015 Tosin Afolabi. All rights reserved.
//

import UIKit
import Cartography

private let kVerticalSpacing = 5.0
private let kContentInset = 20.0
private let kLeftMargin = 13.0

final class FeedTableViewCell: UITableViewCell {
    
    var commentButtonClosure: (() -> Void)?
    
    var commentCount: Int = 0 {
        willSet(newCount) {
            commentsButton.countLabel.text = "\(newCount)"
        }
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .black
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
        button.addTarget(self, action: #selector(FeedTableViewCell.commentButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var borderView: UIView = {
        let view = UIView()
        view.alpha = 0.0
        view.backgroundColor = ColorPalette.Grey.Cloudy
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        layoutMargins = UIEdgeInsets.zero
        backgroundColor = .white
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        
        let infoStackView = UIStackView(arrangedSubviews: [titleLabel, detailLabel])
        infoStackView.configure(distributon: .fill, alignment: .top, axis: .vertical, spacing: 8.0)
        
        let stackView = UIStackView(arrangedSubviews: [infoStackView, commentsButton])
        stackView.configure(distributon: .fill, alignment: .center, axis: .horizontal, spacing: 25.0)
        
        contentView.addSubview(stackView)
        contentView.addSubview(borderView)
        
        constrain(stackView) { stackView in
            stackView.left == stackView.superview!.left + 15
            stackView.right == stackView.superview!.right - 15
            stackView.centerY == stackView.superview!.centerY
        }
        
        constrain(borderView) { borderView in
            borderView.left == borderView.superview!.left
            borderView.width == borderView.superview!.width
            borderView.bottom == borderView.superview!.bottom
            borderView.height == 2
        }
    }
    
    func commentButtonTapped() {
        commentButtonClosure?()
    }
}


