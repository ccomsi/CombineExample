//
//  UserViewModel.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2020/02/25.
//  Copyright © 2020 KIM JUNG HWAN. All rights reserved.
//

import Foundation
import OpenCombine
import OpenCombineFoundation
import DifferenceKit

final class UserViewModel: NSObject {
    
    let model: User
    
    @Published var name: String
    @Published var userName: String
    @Published var email: String

    init(_ model: User) {
        self.model = model
        
        self.name = model.name
        self.userName = model.username
        self.email = model.email
    }
}

extension UserViewModel: Differentiable { }
