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
    
    func postAtIndex(_ index: Int) -> Post {
        return posts[index]
    }
    
    init(type: FeedType) {
        self.type = type
    }
    
    func loadPosts() {
        
        switch self.type {
        
        case .ph, .hn:
            loadPostsFromProductHunt()
        
        case .dn:
            loadPostsFromDesignerNews()
        }
    }
    
    fileprivate func loadPostsFromProductHunt() {
        
        ProductHuntProvider.request(.posts) { (result) in
            switch result {
                
            case let .success(moyaResponse):
                
                let data = moyaResponse.data
                let json = JSON(data: data)
                
                var posts = [Post]()
                for (_, story): (String, JSON) in json["posts"] {
                    let post = Post()
                    DataMapper.map(.ph, post: post, data: story)
                    posts.append(post)
                }
                
                self.posts = posts
                self.completionBlock?()
                
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    fileprivate func loadPostsFromDesignerNews() {
        
        DesignerNewsProvider.request(.stories) { (result) in
            switch result {
                
            case let .success(moyaResponse):
                
                let data = moyaResponse.data
                let json = JSON(data: data)
                
                var posts = [Post]()
                for (_, story): (String, JSON) in json["stories"] {
                    let post = Post()
                    DataMapper.map(.dn, post: post, data: story)
                    posts.append(post)
                }
                
                self.posts = posts
                self.completionBlock?()
                
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
