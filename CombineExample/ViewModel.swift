//
//  ViewModel.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2019/12/18.
//  Copyright © 2019 KIM JUNG HWAN. All rights reserved.
//

import Foundation
import OpenCombine

//class ViewModel: ObservableObject {
//    @Published var text: String
//}

public typealias Published = OpenCombine.Published

class ViewModel {
    @Published var name: String
    @Published var age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
//    func haveBirthday() -> Int {
//        age += 1
//    }
}

