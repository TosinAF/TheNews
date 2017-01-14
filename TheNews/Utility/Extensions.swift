//
//  Extensions.swift
//  TheNews
//
//  Created by Tosin A on 11/2/15.
//  Copyright © 2015 Tosin Afolabi. All rights reserved.
//

// MARK: - Extension+UIStackView

import SafariServices

public extension UIStackView {
    
    public func configure(distributon distribution: UIStackViewDistribution, alignment: UIStackViewAlignment, axis: UILayoutConstraintAxis, spacing: CGFloat) {
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
    }
}

// MARK: - Extension+JTHamburgerButton

import JTHamburgerButton

public extension JTHamburgerButton {
    
    func configure(lineWidth: CGFloat, lineHeight: CGFloat, lineSpacing: CGFloat) {
        self.lineWidth = lineWidth
        self.lineHeight = lineHeight
        self.lineSpacing = lineSpacing
        updateAppearance()
    }
}

// MARK: - Extension+SFSafariViewController

@available(iOS 9.0, *)
class SafariViewController: SFSafariViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //UIApplication.shared.setStatusBarStyle(.default, animated: false)
    }
}
