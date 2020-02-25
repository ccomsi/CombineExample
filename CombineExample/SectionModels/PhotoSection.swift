//
//  PhotoSection.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2020/02/25.
//  Copyright © 2020 KIM JUNG HWAN. All rights reserved.
//

import Foundation
import IGListKit.IGListDiffable

final class PhotoSection: NSObject {
    
    var items: [PhotoNodeModel] = []
    
    init(_ items: [PhotoNodeModel]) {
        self.items = items
    }
}

extension PhotoSection: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self === object ? true : self.isEqual(object)
    }
}
