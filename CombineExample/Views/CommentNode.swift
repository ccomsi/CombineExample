//
//  CommentNode.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2020/02/25.
//  Copyright © 2020 KIM JUNG HWAN. All rights reserved.
//

import AsyncDisplayKit
import TextureSwiftSupport
import Combine

final class CommentNode: ASCellNode {
    
    let viewModel: CommentViewModel
    
    private var cancellable = Set<AnyCancellable>()
    
    private lazy var nameNode: ASTextNode = {
        ASTextNode()
    }()
    
    private lazy var emailNode: ASTextNode = {
        ASTextNode()
    }()
    
    private lazy var bodyNode: ASTextNode = {
        ASTextNode()
    }()
    
    init(_ viewModel: CommentViewModel) {        
        self.viewModel = viewModel
        super.init()
        
        self.automaticallyManagesSubnodes = true
        self.binding()
    }
    
    private func binding() {
        viewModel.$name.map { NSAttributedString(string: $0) }
            .receive(on: DispatchQueue.main)
            .assign(to: \.attributedText, on: nameNode)
            .store(in: &cancellable)
        
        viewModel.$email.map { NSAttributedString(string: $0) }
        .receive(on: DispatchQueue.main)
        .assign(to: \.attributedText, on: emailNode)
        .store(in: &cancellable)
        
        viewModel.$body.map { NSAttributedString(string: $0) }
        .receive(on: DispatchQueue.main)
        .assign(to: \.attributedText, on: bodyNode)
        .store(in: &cancellable)

    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        LayoutSpec {
            VStackLayout {
                nameNode
                emailNode
                bodyNode
            }.width(constrainedSize.max.width)
        }
    }
}
