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
import OpenCombineDispatch

final class PostNode: ASCellNode {
    let cellNodeModel: PostNodeModel
    
    var cancellable = Set<AnyCancellable>()
    
    lazy var titleNode: ASTextNode = {
        ASTextNode()
    }()
    
    lazy var bodyNode: ASTextNode = {
        ASTextNode()
    }()
    
    init(_ nodeModel: PostNodeModel) {
        
        self.cellNodeModel = nodeModel
        super.init()
        
        self.automaticallyManagesSubnodes = true
        self.binding()
    }
    
    func binding() {
        let nodeModel = cellNodeModel
        
        nodeModel.$title.map { NSAttributedString(string: $0) }
            .receive(on: DispatchQueue.main.ocombine)
            .assign(to: \.attributedText, on: titleNode)
            .store(in: &cancellable)
        
        nodeModel.$body.map { NSAttributedString(string: $0) }
            .receive(on: DispatchQueue.main.ocombine)
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
