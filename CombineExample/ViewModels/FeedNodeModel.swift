//
//  ViewModel.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2019/12/18.
//  Copyright © 2019 KIM JUNG HWAN. All rights reserved.
//

import Foundation
import OpenCombine
import OpenCombineFoundation
import OpenCombineDispatch

class FeedNodeModel {
    @Published var title: String
    
    var photoNodeModels = [PhotoNodeModel]()
    var cancellable = [AnyCancellable]()
    
    init(title: String) {
        self.title = title
    }
    
    var numberOfItems: Int {
        return photoNodeModels.count
    }
    
    func itemAtIndexPath(_ indexPath: IndexPath) -> PhotoNodeModel {
        return photoNodeModels[indexPath.row]
    }
    
    func fetch() -> AnyPublisher<[Photo], Error> {
        return URLSession.shared.ocombine
            .dataTaskPublisher(for: URL.URLForModelType(modelType: .photos))
            .map { $0.data }
            .decode(type: [Photo].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
