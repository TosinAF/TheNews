//
//  FeedType.swift
//  TheNews
//
//  Created by Tosin A on 11/15/15.
//  Copyright © 2015 Tosin Afolabi. All rights reserved.
//

import Foundation
import UIKit

struct FeedColor {
    let Brand: UIColor
    let NavBar: UIColor
    let Light: UIColor
}

enum FeedType: Int {
    
    case ph, dn, hn
    
    var title: String {
        let titles = ["PH", "DN", "HN"]
        return titles[self.rawValue]
    }
    
    var filters: [String] {
        switch(self) {
        case .ph:
            return ["TOP", "RECENT"]
        case .dn:
            return ["TOP", "RECENT"]
        case .hn:
            return ["TOP", "NEW", "SHOW", "ASK"]
        }
    }
    
    var colors: FeedColor {
        switch(self) {
        case .ph:
            return FeedColor(Brand: ColorPalette.PH.Brand, NavBar: ColorPalette.PH.Brand, Light: ColorPalette.PH.Light)
        case .dn:
            return FeedColor(Brand: ColorPalette.DN.Brand, NavBar: ColorPalette.DN.NavBar, Light: ColorPalette.DN.Light)
        case .hn:
            return FeedColor(Brand: ColorPalette.HN.Brand, NavBar: ColorPalette.HN.NavBar, Light: ColorPalette.HN.Light)
        }
    }
}
