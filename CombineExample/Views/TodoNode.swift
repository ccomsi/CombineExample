//
//  TodoNode.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2020/02/25.
//  Copyright © 2020 KIM JUNG HWAN. All rights reserved.
//

import AsyncDisplayKit
import TextureSwiftSupport
import Combine

final class TodoNode: ASCellNode {
    
    let viewModel: TodoViewModel
    
    private var cancellable = Set<AnyCancellable>()
    
    private lazy var titleNode: ASTextNode = {
        let node = ASTextNode()
        return node
    }()
    
    init(_ viewModel: TodoViewModel) {        
        self.viewModel = viewModel
        super.init()
        
        self.automaticallyManagesSubnodes = true
        self.binding()
    }
    
    private func binding() {
        viewModel.$title.map { NSAttributedString(string: $0) }
            .receive(on: DispatchQueue.main)
            .assign(to: \.attributedText, on: titleNode)
            .store(in: &cancellable)

    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        LayoutSpec {
            VStackLayout {
                titleNode
            }.width(constrainedSize.max.width)
        }
    }
}
