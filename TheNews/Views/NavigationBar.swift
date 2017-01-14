//
//  NavigationBar.swift
//  TheNews
//
//  Created by Tosin Afolabi on 9/4/15.
//  Copyright © 2015 Tosin Afolabi. All rights reserved.
//

import pop
import UIKit
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
            buttons[newIndex].isSelected = true
            moveIndicatorToButton(atIndex: newIndex)
        }
        
        didSet(oldIndex) {
            buttons[oldIndex].isSelected = false
        }
    }
    
    // MARK: Views
    
    lazy var menuToggle: JTHamburgerButton = {
        let frame = CGRect(x: 0, y: 0, width: kMenuButtonSize, height: kMenuButtonSize)
        let toggle = JTHamburgerButton(frame: frame)
        toggle.lineColor = .white
        toggle.configure(lineWidth: 25.0, lineHeight: 1.0, lineSpacing: 7.0)
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()
    
    lazy var titleView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: self.buttons)
        stackView.configure(distributon: .equalSpacing, alignment: .center, axis: .horizontal, spacing: kButtonSpacing)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var indicatorView: UIView = {
        let indicatorView = UIView()
        indicatorView.layer.cornerRadius = kIndicatorViewSize / 2
        indicatorView.backgroundColor = .white
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }()
    
    // MARK: Initializers
    
    init(titles: [String]) {
        
        self.buttons = titles.map { ButtonFactory.buttonFromTemplate($0) }
        super.init(frame: CGRect.zero)
        
        configureButtons()
        
        addSubview(menuToggle)
        addSubview(titleView)
        addSubview(indicatorView)

        setupConstraints()
        buttons[selectedIndex].isSelected = true
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
    
    func onTap(_ sender: UIButton) {
        
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
            button.addTarget(self, action: #selector(NavigationBar.onTap(_:)), for: .touchUpInside)
            button.tag = index
        }
    }
    
    func moveIndicatorToButton(atIndex index: Int) {
        
        let offset = buttons[index].center.x
        let indicatorAnim = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
        indicatorAnim?.springBounciness = 1
        indicatorAnim?.springSpeed = 1
        indicatorAnim?.toValue = offset
        indicatorViewCenterXConstraint.pop_add(indicatorAnim, forKey: "constant")
    }
}

// MARK: - ButtonFactory Class

private class ButtonFactory {
    
    class func buttonFromTemplate(_ title: String) -> UIButton {
        
        let button = UIButton(frame: CGRect.zero)
        button.setTitle(title, for: UIControlState())
        button.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 15.0)
        button.setTitleColor(UIColor(white: 1.0, alpha: 0.6), for: UIControlState())
        button.setTitleColor(UIColor(white: 1.0, alpha: 1.0), for: .selected)
        return button
    }
}

