//
//  URL.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2020/02/19.
//  Copyright © 2020 KIM JUNG HWAN. All rights reserved.
//

import Foundation

struct Constants {
    
    struct URLS {
        static let Host = "https://jsonplaceholder.typicode.com/"
        static let PhotosEndpoint = "photos"
        static let PostsEndpoint = "posts"
        static let CommentsEndpoint = "comments"
        static let AlbumsEndpoint = "albums"
        static let TodosEndpoint = "todos"
        static let UsersEndpoint = "users"
        
    }
    
}

extension URL {
    
    static func URLForModelType(modelType: ModelType) -> URL {
        switch modelType {
        case .posts:
            return URL(string: assembleURLString(endpoint: Constants.URLS.PostsEndpoint))!
            
        case .photos:
            return URL(string: assembleURLString(endpoint: Constants.URLS.PhotosEndpoint))!
            
        case .comments:
            return URL(string: assembleURLString(endpoint: Constants.URLS.CommentsEndpoint))!
            
        case .albums:
            return URL(string: assembleURLString(endpoint: Constants.URLS.AlbumsEndpoint))!
            
        case .todos:
            return URL(string: assembleURLString(endpoint: Constants.URLS.TodosEndpoint))!
            
        case .users:
            return URL(string: assembleURLString(endpoint: Constants.URLS.UsersEndpoint))!
            
        }
    }
    
    private static func assembleURLString(endpoint: String) -> String {
        return Constants.URLS.Host + endpoint
    }
    
}

enum ModelType: String {
    case posts
    case photos
    case comments
    case albums
    case todos
    case users
}
