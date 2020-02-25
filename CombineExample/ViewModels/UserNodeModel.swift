//
//  UserNodeModel.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2020/02/25.
//  Copyright © 2020 KIM JUNG HWAN. All rights reserved.
//

import Foundation
import OpenCombine
import OpenCombineFoundation
import IGListKit.IGListDiffable

final class UserNodeModel: NSObject {
    
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

extension UserNodeModel: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        self === object
    }
}

