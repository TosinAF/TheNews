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
    
    case PH, DN, HN
    
    var title: String {
        let titles = ["PH", "DN", "HN"]
        return titles[self.rawValue]
    }
    
    var filters: [String] {
        switch(self) {
        case .PH:
            return ["TOP", "RECENT"]
        case .DN:
            return ["TOP", "RECENT"]
        case .HN:
            return ["TOP", "NEW", "SHOW", "ASK"]
        }
    }
    
    var colors: FeedColor {
        switch(self) {
        case .PH:
            return FeedColor(Brand: ColorPalette.PH.Brand, NavBar: ColorPalette.PH.Brand, Light: ColorPalette.PH.Light)
        case .DN:
            return FeedColor(Brand: ColorPalette.DN.Brand, NavBar: ColorPalette.DN.NavBar, Light: ColorPalette.DN.Light)
        case .HN:
            return FeedColor(Brand: ColorPalette.HN.Brand, NavBar: ColorPalette.HN.NavBar, Light: ColorPalette.HN.Light)
        }
    }
}
