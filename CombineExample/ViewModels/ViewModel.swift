//
//  ViewModel.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2021/03/08.
//  Copyright © 2021 KIM JUNG HWAN. All rights reserved.
//

import Foundation
import OpenCombine
import AsyncDisplayKit

typealias ObservableObject = OpenCombine.ObservableObject

class ViewModel: ObservableObject {
    
    func mappedNode() -> ASDisplayNode {
        ASDisplayNode()
    }
    
    func mappedView() -> UIView {
        UIView()
    }
}