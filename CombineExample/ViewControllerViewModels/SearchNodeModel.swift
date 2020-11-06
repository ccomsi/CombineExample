//
//  SearchNodeModel.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2020/02/25.
//  Copyright © 2020 KIM JUNG HWAN. All rights reserved.
//

import Foundation
import OpenCombine
import OpenCombineFoundation
import OpenCombineDispatch
import IGListDiffKit

final class SearchNodeModel: NSObject {
    @Published var title: String
    
    var photoNodeModels = [PhotoNodeModel & ListDiffable]()
    var cancellable = Set<AnyCancellable>()
    
    init(title: String) {
        self.title = title
    }
    
    func fetch() -> AnyPublisher<[Photo], Error> {
        return URLSession.shared.ocombine
            .dataTaskPublisher(for: URL.URLForModelType(modelType: .photos))
            .map { $0.data }
            .decode(type: [Photo].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

extension SearchNodeModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        self === object
    }
}
