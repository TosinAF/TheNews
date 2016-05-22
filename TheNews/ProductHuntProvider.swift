//
//  ProductHuntProvider.swift
//  TheNews
//
//  Created by Tosin Afolabi on 4/26/16.
//  Copyright © 2016 Tosin Afolabi. All rights reserved.
//

import Moya

private let PHAPIBaseURLString = "https://api.producthunt.com/v1"
private let PHAPIClientID      = "7f42a1a52a449fcd9b664ce2cf875564e1f5066c13531e31d307daafb8f630fc"
private let PHAPIClientSecret  = "a2de27344ee25af63b97e8479602d7e0a113592b6d0554f22c4541cc28c3f291"

public enum ProductHunt {
    case ClientAuth
}

//let ProductHuntProvider = MoyaProvider<ProductHunt>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])
let ProductHuntProvider = MoyaProvider<ProductHunt>(plugins: [])

extension ProductHunt: TargetType {
    
    public var baseURL: NSURL {
        return NSURL(string: PHAPIBaseURLString)!
    }
    
    public var path: String {
        switch self {
        case .ClientAuth:
            return "/oauth/token"
        }
    }
    
    public var method: Moya.Method {
        return .POST
    }
    
    public var parameters: [String: AnyObject]? {
        switch self {
        default:
            return [
                "client_id": PHAPIClientID,
                "client_secret": PHAPIClientSecret,
                "grant_type" : "client_credentials"
            ]
        }
    }
    
    public var sampleData: NSData {
        return "[{\"name\": \"Repo Name\"}]".dataUsingEncoding(NSUTF8StringEncoding)!
    }
}
