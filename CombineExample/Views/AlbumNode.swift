//
//  AlbumNode.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2020/02/25.
//  Copyright © 2020 KIM JUNG HWAN. All rights reserved.
//

import AsyncDisplayKit
import TextureSwiftSupport
import OpenCombine
import OpenCombineDispatch

final class AlbumNode: ASCellNode {
    
    let cellNodeModel: AlbumNodeModel
    
    var cancellable = [AnyCancellable]()

    lazy var titleNode: ASTextNode = {
        ASTextNode()
    }()
    
    init(_ nodeModel: AlbumNodeModel) {
        
        self.cellNodeModel = nodeModel
        super.init()
        
        self.automaticallyManagesSubnodes = true
        self.binding()
    }
    
    func binding() {
        let nodeModel = cellNodeModel
        
        nodeModel.$title.map { NSAttributedString(string: $0) }
            .receive(on: DispatchQueue.main.ocombine)
            .assign(to: \.attributedText, on: self.titleNode)
            .store(in: &self.cancellable)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        LayoutSpec {
            VStackLayout {
                titleNode
            }.width(constrainedSize.max.width)
        }
    }
}
