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
    case posts
}

extension ProductHunt: TargetType {

    public var baseURL: URL {
        return URL(string: PHAPIBaseURLString)!
    }
    
    public var path: String {
        switch self {
        case .posts:
            return "/posts"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var parameters: [String: Any]? {
        switch self {
        default:
            return nil
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

class ProductHuntOAuthHelper {
    
    static let tokenURL = URL(string: "\(PHAPIBaseURLString)/oauth/token")!
    static let credentials = OAuthClientCredentials(id: PHAPIClientID, secret: PHAPIClientSecret)
    
    class func hasAccessToken() -> Bool {
        let oAuthService = Heimdallr(tokenURL: tokenURL, credentials: credentials, accessTokenParser: ProductHuntOAuthHelper())
        return oAuthService.hasAccessToken
    }

    class func requestClientAccessToken(_ completion: ((Bool) -> Void)?) {
        
        let oAuthService = Heimdallr(tokenURL: tokenURL, credentials: credentials, accessTokenParser:ProductHuntOAuthHelper())
        
        oAuthService.requestAccessToken(grantType: "client_credentials", parameters: [:]) { (result) in
            switch result {
            case .success:
                print("Successfully Obtained Client Access Token")
                completion?(true)
            case .failure(let error):
                print(error)
                completion?(false)
            }
        }
    }
    
    class func authenticateRequestClosure() -> MoyaProvider<ProductHunt>.RequestClosure {
        
        return { (endpoint: Endpoint<ProductHunt>, done: @escaping (Result<URLRequest, MoyaError>) -> Void) in
            
            guard let request = endpoint.urlRequest else { return }
            let oAuthService = Heimdallr(tokenURL: tokenURL, credentials: credentials, accessTokenParser: ProductHuntOAuthHelper())
            
            let authRequestBlock = {
                oAuthService.authenticateRequest(request) { result in
                    switch result {
                    case .success(let signedRequest):
                        done(.success(signedRequest))
                    case .failure(let error):
                        done(.failure(MoyaError.underlying(error)))
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

    public func parse(data: Data) throws -> OAuthAccessToken {

        if let token = OAuthAccessToken.decode(data: data) {
            let tokenCopy = token.copy(tokenType: "Bearer")
            return tokenCopy
        } else {
            throw NSError(domain: HeimdallrErrorDomain, code: HeimdallrErrorInvalidData, userInfo: nil)
        }
    }

}
