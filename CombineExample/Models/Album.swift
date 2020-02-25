//
//  Album.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2020/02/11.
//  Copyright © 2020 KIM JUNG HWAN. All rights reserved.
//

import Foundation

struct Album: Codable, Hashable {
    
    let userId: Int
    let id: Int
    let title: String
    
    private enum CodingKeys: String, CodingKey {
        case userId
        case id
        case title        
    }
}
