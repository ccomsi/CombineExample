//
//  ViewModel.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2019/12/18.
//  Copyright © 2019 KIM JUNG HWAN. All rights reserved.
//

import Foundation
import OpenCombine
import DifferenceKit

final class FeedViewModel {
    
    enum SectionID: Differentiable, CaseIterable {
        case first, second, third
    }
    
    typealias Section = ArraySection<SectionID, PostViewModel>
    
    @Published var title: String
    
    var data = [Section]()
    
    private var cancellable = Set<AnyCancellable>()
    
    init(title: String) {
        self.title = title
    }
    
    func fetch() -> AnyPublisher<[Post], Error> {
        return URLSession.shared.ocombine
            .dataTaskPublisher(for: URL.URLForModelType(modelType: .posts))
            .map { $0.data }
            .decode(type: [Post].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
