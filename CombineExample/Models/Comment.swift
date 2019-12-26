//
//  Comment.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2020/02/11.
//  Copyright © 2020 KIM JUNG HWAN. All rights reserved.
//

import Foundation

struct Comment: Codable, Hashable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
    
    private enum CodingKeys: String, CodingKey {
        case postId
        case id
        case name
        case email
        case body
    }
}
