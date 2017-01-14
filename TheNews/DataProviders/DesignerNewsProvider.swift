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
    case stories
}

extension DesignerNews: TargetType {
    
    public var baseURL: URL {
        return URL(string: DNAPIBaseURLString)!
    }
    
    public var path: String {
        switch self {
        case .stories:
            return "/stories"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var parameters: [String: Any]? {
        switch self {
        default:
            return ["client_id": DNAPIClientID as Any]
        }
    }

    public var task: Task {
        return .request
    }

    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    public var sampleData: Data {
        return "[{\"name\": \"Repo Name\"}]".data(using: String.Encoding.utf8)!
    }
}



