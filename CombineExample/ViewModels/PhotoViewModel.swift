//
//  PhotoViewModel.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2020/02/11.
//  Copyright © 2020 KIM JUNG HWAN. All rights reserved.
//

import Foundation
import OpenCombine
import OpenCombineFoundation
import DifferenceKit

final class PhotoViewModel: NSObject {
    
    let model: Photo
    
    @Published var title: String
    @Published var thumbnailUrl: URL?

    init(_ model: Photo) {
        self.model = model
        
        self.title = model.title
        self.thumbnailUrl = URL(string: model.thumbnailUrl)
    }
}

extension PhotoViewModel: Differentiable { }
