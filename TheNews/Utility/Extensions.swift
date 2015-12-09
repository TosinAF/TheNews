//
//  Extensions.swift
//  TheNews
//
//  Created by Tosin A on 11/2/15.
//  Copyright © 2015 Tosin Afolabi. All rights reserved.
//

// MARK: - Extension+TZStackView

import TZStackView

public extension TZStackView {
    
    public func configure(distributon distribution: TZStackViewDistribution, alignment: TZStackViewAlignment, axis: UILayoutConstraintAxis, spacing: CGFloat) {
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
    }
}

// MARK: - Extension+JTHamburgerButton

import JTHamburgerButton

public extension JTHamburgerButton {
    
    func configure(lineWidth lineWidth: CGFloat, lineHeight: CGFloat, lineSpacing: CGFloat) {
        self.lineWidth = lineWidth
        self.lineHeight = lineHeight
        self.lineSpacing = lineSpacing
        updateAppearance()
    }
}

// MARK: - Extension+UIView

import UIKit

extension UIView {
    
    func takeSnapshot() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.mainScreen().scale)
        drawViewHierarchyInRect(self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}




