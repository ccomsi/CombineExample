//
//  CommentViewModel.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2020/02/25.
//  Copyright © 2020 KIM JUNG HWAN. All rights reserved.
//

import Foundation
import Combine
import DifferenceKit

final class CommentViewModel: NSObject {
    
    let model: Comment
    
    @Published var name: String
    @Published var email: String
    @Published var body: String

    init(_ model: Comment) {
        self.model = model
        
        self.name = model.name
        self.email = model.email
        self.body = model.body
    }
}

extension CommentViewModel: Differentiable { }
