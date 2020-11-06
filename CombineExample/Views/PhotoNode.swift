//
//  PhotoNode.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2020/02/11.
//  Copyright © 2020 KIM JUNG HWAN. All rights reserved.
//

import AsyncDisplayKit
import TextureSwiftSupport
import OpenCombine
import OpenCombineDispatch

final class PhotoNode: ASCellNode {

    let cellNodeModel: PhotoNodeModel
    
    var cancellable = [AnyCancellable]()
    
    lazy var imageNode: ASNetworkImageNode = {
        ASNetworkImageNode()
    }()
    
    lazy var textNode: ASTextNode = {
        ASTextNode()
    }()
    
    init(_ nodeModel: PhotoNodeModel) {
        
        self.cellNodeModel = nodeModel
        super.init()
        
        self.automaticallyManagesSubnodes = true
        self.binding()        
    }
    
    func binding() {
        let nodeModel = cellNodeModel
        
        nodeModel.$title.map { NSAttributedString(string: $0) }
            .receive(on: DispatchQueue.main.ocombine)
            .assign(to: \.attributedText, on: self.textNode)
            .store(in: &self.cancellable)
        
        nodeModel.$thumbnailUrl.map { $0 }
            .receive(on: DispatchQueue.main.ocombine)
            .assign(to: \.url, on: self.imageNode)
            .store(in: &self.cancellable)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

        LayoutSpec {
            VStackLayout {
                textNode
                imageNode.preferredSize(CGSize(width: 100, height: 100))
            }.width(constrainedSize.max.width)
        }
    }
    
}
