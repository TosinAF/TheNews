//
//  DataMapper.swift
//  TheNews
//
//  Created by Tosin Afolabi on 4/26/16.
//  Copyright © 2016 Tosin Afolabi. All rights reserved.
//

import SwiftyJSON

class DataMapper {
    
    class func map(post: Post, data: JSON) {
        post.id = data["id"].stringValue
        post.title = data["title"].stringValue
        post.author = data["user_display_name"].stringValue
        post.commentCount = data["comment_count"].intValue
        post.points = data["vote_count"].intValue
        post.storyURL = data["url"].stringValue
    }
}
