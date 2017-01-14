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

func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}
