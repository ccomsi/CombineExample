//
//  Album.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2020/02/11.
//  Copyright © 2020 KIM JUNG HWAN. All rights reserved.
//

import Foundation

struct Photo: Codable, Hashable {
    
    var id: Int
    var albumId: Int
    var title: String
    var thumbnailUrl: String
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case albumId
        case title
        case thumbnailUrl
    }
}
