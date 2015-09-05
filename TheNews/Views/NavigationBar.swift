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

class NavigationBar: UINavigationBar {
    
    // MARK: Properties
    
    let buttons: [UIButton]
    
    var selectedIndex = 0 {
    
        willSet(newIndex) {
            buttons[newIndex].selected = true
            moveIndicatorToButton(atIndex: newIndex)
        }
        
        didSet(oldIndex) {
            buttons[oldIndex].selected = false
        }
    }
    
    var indicatorViewCenterXConstraint = NSLayoutConstraint()
    
    lazy var navigationItem: UINavigationItem = {
        
        let menuBarButton = UIBarButtonItem(customView: self.menuToggle)
        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: "")
        negativeSpacer.width = -10
        
        let navigationItem = UINavigationItem(title: "")
        navigationItem.titleView = self.titleView
        navigationItem.leftBarButtonItems = [negativeSpacer, menuBarButton]
        return navigationItem
    }()
    
    lazy var menuToggle: JTHamburgerButton = {
        let toggle = JTHamburgerButton(frame: CGRectMake(0, 0, 40, 40))
        toggle.lineWidth = 25.0
        toggle.lineHeight = 1.0
        toggle.lineSpacing = 7.0
        toggle.lineColor = .whiteColor()
        toggle.updateAppearance()
        return toggle
    }()
    
    lazy var titleView: TZStackView = {
        let stackView = TZStackView(arrangedSubviews: self.buttons)
        stackView.distribution = .EqualSpacing
        stackView.alignment = .Center
        stackView.axis = .Horizontal
        stackView.spacing = 25
        return stackView
    }()
    
    lazy var indicatorView: UIView = {
        let indicatorView = UIView()
        indicatorView.layer.cornerRadius = 2.5
        indicatorView.backgroundColor = .whiteColor()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }()
    
    // MARK: Initializers
    
    init(titles: [String]) {
        
        self.buttons = titles.map { ButtonFactory.buttonFromTemplate($0) }
        super.init(frame: CGRectZero)
        
        configureButtons()
        addSubview(indicatorView)
        pushNavigationItem(navigationItem, animated: false)

        setupConstraints()
        buttons[selectedIndex].selected = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    
    func setupConstraints() {
        
        layout(titleView) { stackView in
            stackView.centerX == stackView.superview!.centerX + 12
            stackView.centerY == stackView.superview!.centerY + 10
        }
        
        let offset = buttons[selectedIndex].center.x
        layout(indicatorView, buttons[selectedIndex], titleView) { indicatorView, button, titleView in
            indicatorView.width == 5.0
            indicatorView.height == 5.0
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

