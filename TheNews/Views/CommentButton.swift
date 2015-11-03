//
//  CommentButton.swift
//  TheNews
//
//  Created by Tosin A on 11/2/15.
//  Copyright © 2015 Tosin Afolabi. All rights reserved.
//

import UIKit
import Cartography

final class CommentButton: UIButton {
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        label.text = "13"
        label.font = UIFont(name: "Montserrat", size: 13.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var iconImageView: UIImageView = {
        let image = UIImage(named: "chat")?.imageWithRenderingMode(.AlwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.tintColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        imageView.alpha = 0.8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: CGRectZero)
        
        addSubview(countLabel)
        addSubview(iconImageView)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        let views = ["count": countLabel, "icon": iconImageView]
        let metrics = ["vMargin": 7]
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-vMargin-[count]-2-[icon]-vMargin-|", options: [], metrics: metrics, views: views))
        
        constrain(countLabel, iconImageView) { countLabel, iconImageView in
            countLabel.centerX == countLabel.superview!.centerX
            iconImageView.centerX == iconImageView.superview!.centerX
        }
    }
}
