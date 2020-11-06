//
//  TodoNodeModel.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2020/02/25.
//  Copyright © 2020 KIM JUNG HWAN. All rights reserved.
//

import Foundation
import OpenCombine
import OpenCombineFoundation
import IGListDiffKit

final class TodoNodeModel: NSObject {
    
    let model: Todo
    
    @Published var title: String
    @Published var completed: Bool

    init(_ model: Todo) {
        self.model = model
        
        self.title = model.title
        self.completed = model.completed
    }
}

extension TodoNodeModel: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        self === object
    }
}
