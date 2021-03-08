//
//  AlbumViewModel.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2020/02/25.
//  Copyright © 2020 KIM JUNG HWAN. All rights reserved.
//

import Foundation
import OpenCombine
import OpenCombineFoundation
import DifferenceKit

final class AlbumViewModel: NSObject {
    
    let model: Album
    
    @Published var title: String

    init(_ model: Album) {
        self.model = model
        
        self.title = model.title
    }
}

extension AlbumViewModel: Differentiable { }
