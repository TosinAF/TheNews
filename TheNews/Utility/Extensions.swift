//
//  Extensions.swift
//  TheNews
//
//  Created by Tosin A on 11/2/15.
//  Copyright © 2015 Tosin Afolabi. All rights reserved.
//

// MARK: - Extension+TZStackView

import TZStackView
import SafariServices
import TOWebViewController

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

// MARK: - Extension+SFSafariViewController

@available(iOS 9.0, *)
class SafariViewController: SFSafariViewController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: false)
    }
}

// MARK: - Extension+TOWebViewController

class WebViewController: TOWebViewController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: false)
    }
}
