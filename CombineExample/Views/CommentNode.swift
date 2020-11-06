//
//  CommentNode.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2020/02/25.
//  Copyright © 2020 KIM JUNG HWAN. All rights reserved.
//

import AsyncDisplayKit
import TextureSwiftSupport
import OpenCombine
import OpenCombineDispatch

final class CommentNode: ASCellNode {
    
    let cellNodeModel: CommentNodeModel
    
    var cancellable = Set<AnyCancellable>()
    
    lazy var nameNode: ASTextNode = {
        ASTextNode()
    }()
    
    lazy var emailNode: ASTextNode = {
        ASTextNode()
    }()
    
    lazy var bodyNode: ASTextNode = {
        ASTextNode()
    }()
    
    init(_ nodeModel: CommentNodeModel) {
        
        self.cellNodeModel = nodeModel
        super.init()
        
        self.automaticallyManagesSubnodes = true
        self.binding()
    }
    
    func binding() {
        let nodeModel = cellNodeModel
        
        nodeModel.$name.map { NSAttributedString(string: $0) }
            .receive(on: DispatchQueue.main.ocombine)
            .assign(to: \.attributedText, on: nameNode)
            .store(in: &cancellable)
        
        nodeModel.$email.map { NSAttributedString(string: $0) }
        .receive(on: DispatchQueue.main.ocombine)
        .assign(to: \.attributedText, on: emailNode)
        .store(in: &cancellable)
        
        nodeModel.$body.map { NSAttributedString(string: $0) }
        .receive(on: DispatchQueue.main.ocombine)
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
