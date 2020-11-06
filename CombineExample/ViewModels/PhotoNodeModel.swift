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
import IGListDiffKit

final class PhotoNodeModel: NSObject {
    
    let model: Photo
    
    @Published var title: String
    @Published var thumbnailUrl: URL?

    init(_ model: Photo) {
        self.model = model
        
        self.title = model.title
        self.thumbnailUrl = URL(string: model.thumbnailUrl)
    }
}

extension PhotoNodeModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        self === object
    }
}
