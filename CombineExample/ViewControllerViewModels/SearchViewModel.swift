//
//  SearchViewModel.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2020/02/25.
//  Copyright © 2020 KIM JUNG HWAN. All rights reserved.
//

import Foundation
import Combine
import DifferenceKit

final class SearchViewModel: NSObject {
    
    enum SectionID: Differentiable, CaseIterable {
        case first, second, third
    }
    
    typealias Section = ArraySection<SectionID, PhotoViewModel>
    
    @Published var title: String
    
    var data = [Section]()
    
    private var cancellable = Set<AnyCancellable>()
    
    init(title: String) {
        self.title = title
    }
    
    func fetch() -> AnyPublisher<[Photo], Error> {
        return URLSession.shared
            .dataTaskPublisher(for: URL.URLForModelType(modelType: .photos))
            .map { $0.data }
            .decode(type: [Photo].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

extension SearchViewModel: Differentiable { }
