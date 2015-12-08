//
//  Constants.swift
//  TheNews
//
//  Created by Tosin Afolabi on 12/7/15.
//  Copyright © 2015 Tosin Afolabi. All rights reserved.
//

import Foundation
import UIKit

let kNavigationBarHeight: CGFloat = 64.0

func delay(delay:Double, closure:()->()) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))),
        dispatch_get_main_queue(), closure)
}