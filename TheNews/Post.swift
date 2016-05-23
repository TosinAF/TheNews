//
//  Post.swift
//  TheNews
//
//  Created by Tosin Afolabi on 4/24/16.
//  Copyright © 2016 Tosin Afolabi. All rights reserved.
//

class Post {
    
    var id = ""
    var title = ""
    var author = ""
    var points = 0
    var commentCount = 0
    var url = ""
    
    var detailText: String {
        return "\(points) points by \(author)"
    }
}
