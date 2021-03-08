//
//  PostNode.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2020/02/25.
//  Copyright © 2020 KIM JUNG HWAN. All rights reserved.
//

import AsyncDisplayKit
import TextureSwiftSupport
import OpenCombine

final class PostNode: ASCellNode {
    let viewModel: PostViewModel
    
    private var cancellable = Set<AnyCancellable>()
    
    private lazy var titleNode: ASTextNode = {
        let node = ASTextNode()
        return node
    }()
    
    private lazy var bodyNode: ASTextNode = {
        let node = ASTextNode()
        return node
    }()
    
    init(_ viewModel: PostViewModel) {        
        self.viewModel = viewModel
        super.init()
        
        self.automaticallyManagesSubnodes = true
        self.binding()
    }
    
    private func binding() {
        viewModel.$title
            .map { NSAttributedString(string: $0) }
            .assign(to: \.attributedText, on: titleNode)
            .store(in: &cancellable)
        
        viewModel.$body
            .map { NSAttributedString(string: $0) }
            .assign(to: \.attributedText, on: bodyNode)
            .store(in: &cancellable)

    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

        LayoutSpec {
            VStackLayout {
                titleNode
                bodyNode
            }.width(constrainedSize.max.width)
        }
    }
}
