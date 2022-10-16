//
//  PostViewModel.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2020/02/25.
//  Copyright © 2020 KIM JUNG HWAN. All rights reserved.
//

import Foundation
import Combine
import DifferenceKit

class PostViewModel: NSObject {

    let model: Post
    
    @Published var title: String    
    @Published var body: String
    
    init(_ model: Post) {
        self.model = model
        
        self.title = model.title
        self.body = model.body
    }
}

extension PostViewModel: Differentiable { }
