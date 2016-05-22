//
//  CommentTableViewCell.swift
//  TheNews
//
//  Created by Tosin A on 11/25/15.
//  Copyright © 2015 Tosin Afolabi. All rights reserved.
//

import UIKit
import TZStackView
import Cartography

class CommentTableViewCell: UITableViewCell {

    lazy var textView: UITextView = {
        let textView = UITextView(frame: .zero, textContainer: nil)
        textView.font = UIFont.systemFontOfSize(14.0)
        textView.textColor = UIColor(red:0.424,  green:0.478,  blue:0.537, alpha:1)
        textView.text = "Mountains revaluation dead ideal philosophy faithful fearful dead ultimate pinnacle suicide. Ascetic prejudice endless self christianity truth of ultimate ultimate."
        textView.scrollEnabled = false
        textView.editable = false
        textView.textAlignment = .Justified
        return textView
    }()
    
    lazy var authorTextView: UITextView = {
        let textView = UITextView(frame: .zero, textContainer: nil)
        textView.text = "NIETZSCHE IPSUM"
        textView.textColor = ColorPalette.DN.Light
        textView.font = UIFont.systemFontOfSize(11.0)
        textView.scrollEnabled = false
        textView.editable = false
        return textView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutMargins = UIEdgeInsetsZero
        selectionStyle = .None
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        
        let stackView = TZStackView(arrangedSubviews: [textView, authorTextView])
        stackView.configure(distributon: .Fill, alignment: .Top, axis: .Vertical, spacing: 0.0)
        
        contentView.addSubview(stackView)
        
        constrain(stackView) { stackView in
            stackView.edges == inset(stackView.superview!.edges, 10, 15, 10, 15)
        }
    }
}