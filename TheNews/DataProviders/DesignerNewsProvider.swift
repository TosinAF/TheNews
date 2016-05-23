//
//  DNProvider.swift
//  TheNews
//
//  Created by Tosin Afolabi on 4/24/16.
//  Copyright © 2016 Tosin Afolabi. All rights reserved.
//

import Moya

private let DNAPIBaseURLString = "https://www.designernews.co/api/v1"
private let DNAPIClientID      = "3ba6addb82f5746189bbf3e59ac06a0d498f02309ae4d7119655be174528ad44"
private let DNAPIClientSecret  = "29f00d2f31eb18f622f55b30cdb1b745e45e940bc7a6192014a0131f40397f78"

private let plugins = [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)]
let DesignerNewsProvider = MoyaProvider<DesignerNews>(plugins: [])

public enum DesignerNews {
    case Stories
}

extension DesignerNews: TargetType {
    
    public var baseURL: NSURL {
        return NSURL(string: DNAPIBaseURLString)!
    }
    
    public var path: String {
        switch self {
        case .Stories:
            return "/stories"
        }
    }
    
    public var method: Moya.Method {
        return .GET
    }
    
    public var parameters: [String: AnyObject]? {
        switch self {
        default:
            return ["client_id": DNAPIClientID]
        }
    }
    
    public var sampleData: NSData {
        return "[{\"name\": \"Repo Name\"}]".dataUsingEncoding(NSUTF8StringEncoding)!
    }
}



