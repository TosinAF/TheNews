//
//  JSONResponseDataFormatter.swift
//  TheNews
//
//  Created by Tosin Afolabi on 4/24/16.
//  Copyright © 2016 Tosin Afolabi. All rights reserved.
//

import Foundation

public func JSONResponseDataFormatter(data: NSData) -> NSData {
    do {
        let dataAsJSON = try NSJSONSerialization.JSONObjectWithData(data, options: [])
        let prettyData =  try NSJSONSerialization.dataWithJSONObject(dataAsJSON, options: .PrettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it cant be serialized
    }
}