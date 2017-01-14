//
//  JSONResponseDataFormatter.swift
//  TheNews
//
//  Created by Tosin Afolabi on 4/24/16.
//  Copyright © 2016 Tosin Afolabi. All rights reserved.
//

import Foundation

public func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data, options: [])
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it cant be serialized
    }
}
