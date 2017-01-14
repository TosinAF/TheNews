//
//  DataMapper.swift
//  TheNews
//
//  Created by Tosin Afolabi on 4/26/16.
//  Copyright © 2016 Tosin Afolabi. All rights reserved.
//

import SwiftyJSON

class DataMapper {
    
    class func map(_ type: FeedType, post: Post, data: JSON) {
        switch type {
        case .ph, .hn:
            mapForPH(post, data: data)
        
        case .dn:
            print(data)
            mapForDN(post, data: data)
        }
    }
    
    class func mapForDN(_ post: Post, data: JSON) {
        post.id = data["id"].stringValue
        post.title = data["title"].stringValue
        post.author = data["user_display_name"].stringValue
        post.commentCount = data["comment_count"].intValue
        post.points = data["vote_count"].intValue
        post.url = data["url"].stringValue
    }
    
    class func mapForPH(_ post: Post, data: JSON) {
        post.id = data["id"].stringValue
        post.title = "\(data["name"]): \(data["tagline"])"
        post.author = data["user"]["name"].stringValue
        post.commentCount = data["comments_count"].intValue
        post.points = data["votes_count"].intValue
        post.url = data["redirect_url"].stringValue
    }
}
