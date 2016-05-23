//
//  FeedViewModel.swift
//  TheNews
//
//  Created by Tosin Afolabi on 5/22/16.
//  Copyright © 2016 Tosin Afolabi. All rights reserved.
//

import SwiftyJSON

class FeedViewModel {
    
    let type: FeedType
    
    var posts = [Post]()
    
    var completionBlock: (() -> Void)?
    
    func numberOfPosts() -> Int {
        return posts.count
    }
    
    func postAtIndex(index: Int) -> Post {
        return posts[index]
    }
    
    init(type: FeedType) {
        self.type = type
    }
    
    func loadPosts() {
        
        switch self.type {
        
        case .PH, .HN:
            loadPostsFromProductHunt()
        
        case .DN:
            loadPostsFromDesignerNews()
        }
    }
    
    private func loadPostsFromProductHunt() {
        
        ProductHuntProvider.request(.Posts) { (result) in
            switch result {
                
            case let .Success(moyaResponse):
                
                let data = moyaResponse.data
                let json = JSON(data: data)
                
                var posts = [Post]()
                for (_, story): (String, JSON) in json["posts"] {
                    let post = Post()
                    DataMapper.map(.PH, post: post, data: story)
                    posts.append(post)
                }
                
                self.posts = posts
                self.completionBlock?()
                
            case .Failure(let error):
                print(error)
                break
            }
        }
    }
    
    private func loadPostsFromDesignerNews() {
        
        DesignerNewsProvider.request(.Stories) { (result) in
            switch result {
                
            case let .Success(moyaResponse):
                
                let data = moyaResponse.data
                let json = JSON(data: data)
                
                var posts = [Post]()
                for (_, story): (String, JSON) in json["stories"] {
                    let post = Post()
                    DataMapper.map(.DN, post: post, data: story)
                    posts.append(post)
                }
                
                self.posts = posts
                self.completionBlock?()
                
            case .Failure(let error):
                print(error)
                break
            }
        }
    }
}
