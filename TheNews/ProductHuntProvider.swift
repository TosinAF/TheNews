//
//  ProductHuntProvider.swift
//  TheNews
//
//  Created by Tosin Afolabi on 4/26/16.
//  Copyright © 2016 Tosin Afolabi. All rights reserved.
//

import Moya
import Result
import Heimdallr

private let PHAPIBaseURLString      = "https://api.producthunt.com/v1"
private let PHAPIClientID           = "7f42a1a52a449fcd9b664ce2cf875564e1f5066c13531e31d307daafb8f630fc"
private let PHAPIClientSecret       = "a2de27344ee25af63b97e8479602d7e0a113592b6d0554f22c4541cc28c3f291"
private let PHAPIClientGrantType    = "client_credentials"

private let plugins = [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)]

let ProductHuntProvider = MoyaProvider<ProductHunt>(requestClosure: ProductHuntOAuthHelper.authenticateRequestClosure(), plugins: [])

public enum ProductHunt {
    case Posts
}

extension ProductHunt: TargetType {
    
    public var baseURL: NSURL {
        return NSURL(string: PHAPIBaseURLString)!
    }
    
    public var path: String {
        switch self {
        case .Posts:
            return "/posts"
        }
    }
    
    public var method: Moya.Method {
        return .GET
    }
    
    public var parameters: [String: AnyObject]? {
        switch self {
        default:
            return nil
        }
    }
    
    public var sampleData: NSData {
        return "[{\"name\": \"Repo Name\"}]".dataUsingEncoding(NSUTF8StringEncoding)!
    }
}

class ProductHuntOAuthHelper {
    
    static let tokenURL = NSURL(string: "\(PHAPIBaseURLString)/oauth/token")!
    static let credentials = OAuthClientCredentials(id: PHAPIClientID, secret: PHAPIClientSecret)
    
    class func hasAccessToken() -> Bool {
        let oAuthService = Heimdallr(tokenURL: tokenURL, credentials: credentials, accessTokenParser: ProductHuntOAuthHelper())
        return oAuthService.hasAccessToken
    }

    class func requestClientAccessToken(completion: ((Bool) -> Void)?) {
        
        let oAuthService = Heimdallr(tokenURL: tokenURL, credentials: credentials, accessTokenParser:ProductHuntOAuthHelper())
        
        oAuthService.requestAccessToken(grantType: "client_credentials", parameters: [:]) { (result) in
            switch result {
            case .Success:
                print("Successfully Obtained Client Access Token")
                completion?(true)
            case .Failure(let error):
                print(error)
                completion?(false)
            }
        }
    }
    
    class func authenticateRequestClosure() -> MoyaProvider<ProductHunt>.RequestClosure {
        
        return { (endpoint: Endpoint<ProductHunt>, done: NSURLRequest -> Void) in
            
            let request = endpoint.urlRequest
            let oAuthService = Heimdallr(tokenURL: tokenURL, credentials: credentials, accessTokenParser: ProductHuntOAuthHelper())
            
            let authRequestBlock = {
                oAuthService.authenticateRequest(request) { result in
                    switch result {
                    case .Success(let signedRequest):
                        done(signedRequest)
                    case .Failure(let error):
                        print(error)
                    }
                }
            }
            
            if !ProductHuntOAuthHelper.hasAccessToken() {
                ProductHuntOAuthHelper.requestClientAccessToken({ (success) in
                    authRequestBlock()
                })
            }
            
            authRequestBlock()
        }
    }
}

extension ProductHuntOAuthHelper: OAuthAccessTokenParser {
    func parse(data: NSData) -> Result<OAuthAccessToken, NSError> {
        
        let decoded = OAuthAccessToken.decode(data)
        
        switch decoded {
        case .Success(let token):
            let tokenCopy = token.copy(tokenType: "Bearer")
            return .Success(tokenCopy)
        case .Failure:
            let error = NSError(domain: HeimdallrErrorDomain, code: HeimdallrErrorInvalidData, userInfo: nil)
            return .Failure(error)
        }
    }
}