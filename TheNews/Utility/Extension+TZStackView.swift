//
//  Extension+TZStackView.swift
//  TheNews
//
//  Created by Tosin A on 11/2/15.
//  Copyright © 2015 Tosin Afolabi. All rights reserved.
//

import TZStackView

public extension TZStackView {
    
    public func configure(distributon distribution: TZStackViewDistribution, alignment: TZStackViewAlignment, axis: UILayoutConstraintAxis, spacing: CGFloat) {
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
    }
}


