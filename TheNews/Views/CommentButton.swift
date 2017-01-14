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
        label.textColor = UIColor.black.withAlphaComponent(0.8)
        label.text = "13"
        label.font = UIFont(name: "Montserrat", size: 13.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var iconImageView: UIImageView = {
        let image = UIImage(named: "chat")?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.tintColor = UIColor.black.withAlphaComponent(0.8)
        imageView.alpha = 0.8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: CGRect.zero)
        
        addSubview(countLabel)
        addSubview(iconImageView)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupConstraints() {
        
        let views = ["count": countLabel, "icon": iconImageView] as [String : Any]
        let metrics = ["vMargin": 7]
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-vMargin-[count]-2-[icon]-vMargin-|", options: [], metrics: metrics, views: views))
        
        constrain(countLabel, iconImageView) { countLabel, iconImageView in
            countLabel.centerX == countLabel.superview!.centerX
            iconImageView.centerX == iconImageView.superview!.centerX
        }
    }
}
