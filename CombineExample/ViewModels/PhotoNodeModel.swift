//
//  PhotoNodeModel.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2020/02/11.
//  Copyright © 2020 KIM JUNG HWAN. All rights reserved.
//

import Foundation
import OpenCombine
import OpenCombineFoundation

class PhotoNodeModel {
    let model: Photo
    
    @Published var title: String
    @Published var thumbnailUrl: URL?

    init(_ photo: Photo) {
        self.model = photo
        self.title = photo.title
        self.thumbnailUrl = URL(string: photo.thumbnailUrl)
    }
}
