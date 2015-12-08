//
//  QuickSwitcherView.swift
//  TheNews
//
//  Created by Tosin A on 11/15/15.
//  Copyright © 2015 Tosin Afolabi. All rights reserved.
//

import UIKit
import TZStackView
import Cartography

private let kButtonSpacing: CGFloat = 10.0
private let kVerticalPadding: CGFloat = 15.0

class QuickSwitcherView: UIView {
    
    // MARK: Properties
    
    let buttons: [UIButton]
    
    var selectionClosure: ((type: FeedType) -> Void)?
    
    lazy var stackView: TZStackView = {
        let stackView = TZStackView(arrangedSubviews: self.buttons)
        stackView.configure(distributon: .EqualSpacing, alignment: .Center, axis: .Horizontal, spacing: kButtonSpacing)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: Initializers
    
    init(feedTypes: [FeedType]) {
        
        self.buttons = feedTypes.map { ButtonFactory.buttonFromTemplate($0) }
        super.init(frame: CGRectZero)
        
        for button in buttons {
            button.addTarget(self, action: "onTap:", forControlEvents: .TouchUpInside)
        }
        
        backgroundColor = ColorPalette.Grey.Cloudy.colorWithAlphaComponent(0.8)
        
        addSubview(stackView)
        
        constrain(stackView) { stackView in
            stackView.edges == inset(stackView.superview!.edges, 0, kVerticalPadding, 0, kVerticalPadding)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    
    func onTap(sender: UIButton) {
        
        guard let type = FeedType(rawValue: sender.tag) else {
            fatalError("FeedType dosent exist")
        }
        
        selectionClosure?(type: type)
    }
}

// MARK: - ButtonFactory Class

private class ButtonFactory {
    
    class func buttonFromTemplate(type: FeedType) -> UIButton {
        
        let button = UIButton(frame: CGRectZero)
        button.setTitle(type.title, forState: .Normal)
        button.setTitleColor(type.colors.Brand, forState: .Normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 18.0)
        button.tag = type.rawValue
        return button
    }
}
