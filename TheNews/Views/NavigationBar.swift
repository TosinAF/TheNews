//
//  NavigationBar.swift
//  TheNews
//
//  Created by Tosin Afolabi on 9/4/15.
//  Copyright © 2015 Tosin Afolabi. All rights reserved.
//

import pop
import UIKit
import TZStackView
import Cartography
import JTHamburgerButton

private let kButtonSpacing: CGFloat = 25.0
private let kMenuButtonSize: CGFloat = 40.0
private let kIndicatorViewSize: CGFloat = 5.0
private let kTitleViewCenterXOffset: CGFloat = 12.0
private let kTitleViewCenterYOffset: CGFloat = 10.0

class NavigationBar: UINavigationBar {
    
    // MARK: Properties
    
    let buttons: [UIButton]
    
    var indicatorViewCenterXConstraint = NSLayoutConstraint()
    
    var selectedIndex = 0 {
    
        willSet(newIndex) {
            buttons[newIndex].selected = true
            moveIndicatorToButton(atIndex: newIndex)
        }
        
        didSet(oldIndex) {
            buttons[oldIndex].selected = false
        }
    }
    
    // MARK: Views
    
    lazy var menuToggle: JTHamburgerButton = {
        let frame = CGRectMake(0, 0, kMenuButtonSize, kMenuButtonSize)
        let toggle = JTHamburgerButton(frame: frame)
        toggle.configure(lineWidth: 25.0, lineHeight: 1.0, lineSpacing: 7.0)
        toggle.lineColor = .whiteColor()
        toggle.updateAppearance()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()
    
    lazy var titleView: TZStackView = {
        let stackView = TZStackView(arrangedSubviews: self.buttons)
        stackView.configure(distributon: .EqualSpacing, alignment: .Center, axis: .Horizontal, spacing: kButtonSpacing)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var indicatorView: UIView = {
        let indicatorView = UIView()
        indicatorView.layer.cornerRadius = kIndicatorViewSize / 2
        indicatorView.backgroundColor = .whiteColor()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }()
    
    // MARK: Initializers
    
    init(titles: [String]) {
        
        self.buttons = titles.map { ButtonFactory.buttonFromTemplate($0) }
        super.init(frame: CGRectZero)
        
        configureButtons()
        
        addSubview(menuToggle)
        addSubview(titleView)
        addSubview(indicatorView)

        setupConstraints()
        buttons[selectedIndex].selected = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    
    func setupConstraints() {
        
        constrain(menuToggle, titleView) { menuToggle, titleView in
            menuToggle.left == menuToggle.superview!.left + 12
            menuToggle.centerY == titleView.centerY
        }
        
        let centerXOffset = buttons.count <= 2 ? 0.0 : kTitleViewCenterXOffset
        constrain(titleView) { titleView in
            titleView.centerX == titleView.superview!.centerX + centerXOffset
            titleView.centerY == titleView.superview!.centerY + kTitleViewCenterYOffset
        }
        
        layoutIfNeeded()
        
        let offset = buttons[selectedIndex].center.x
        constrain(indicatorView, buttons[selectedIndex], titleView) { indicatorView, button, titleView in
            indicatorView.width == kIndicatorViewSize
            indicatorView.height == kIndicatorViewSize
            indicatorView.bottom == button.bottom
            indicatorViewCenterXConstraint = (indicatorView.centerX == titleView.left + offset)
        }
    }
    
    // MARK: Actions
    
    func onTap(sender: UIButton) {
        
        if selectedIndex == sender.tag {
            return
        }
        
        selectedIndex = sender.tag
    }
    
    // MARK: Helper Methods
    
    func configureButtons() {
        
        for index in 0..<buttons.count {
            let button = buttons[index]
            addSubview(button)
            button.addTarget(self, action: "onTap:", forControlEvents: .TouchUpInside)
            button.tag = index
        }
    }
    
    func moveIndicatorToButton(atIndex index: Int) {
        
        let offset = buttons[index].center.x
        let indicatorAnim = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
        indicatorAnim.springBounciness = 1
        indicatorAnim.springSpeed = 1
        indicatorAnim.toValue = offset
        indicatorViewCenterXConstraint.pop_addAnimation(indicatorAnim, forKey: "constant")
    }
}

// MARK: - ButtonFactory Class

private class ButtonFactory {
    
    class func buttonFromTemplate(title: String) -> UIButton {
        
        let button = UIButton(frame: CGRectZero)
        button.setTitle(title, forState: .Normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 15.0)
        button.setTitleColor(UIColor(white: 1.0, alpha: 0.6), forState: .Normal)
        button.setTitleColor(UIColor(white: 1.0, alpha: 1.0), forState: .Selected)
        return button
    }
}

// MARK: - JTHamburgerButton Extension

private extension JTHamburgerButton {
    
    func configure(lineWidth lineWidth: CGFloat, lineHeight: CGFloat, lineSpacing: CGFloat) {
        self.lineWidth = lineWidth
        self.lineHeight = lineHeight
        self.lineSpacing = lineSpacing
    }
}

