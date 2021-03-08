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

final class PhotoNode: ASCellNode {

    let viewModel: PhotoViewModel
    
    private var cancellable = Set<AnyCancellable>()
    
    private lazy var imageNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        return node
    }()
    
    private lazy var textNode: ASTextNode = {
        let node = ASTextNode()
        return node
    }()
    
    init(_ viewModel: PhotoViewModel) {
        self.viewModel = viewModel
        super.init()
        
        self.automaticallyManagesSubnodes = true
        self.binding()        
    }
    
    private func binding() {
        viewModel.$title.map { NSAttributedString(string: $0) }
            .receive(on: DispatchQueue.main.ocombine)
            .assign(to: \.attributedText, on: textNode)
            .store(in: &cancellable)
        
        viewModel.$thumbnailUrl.map { $0 }
            .receive(on: DispatchQueue.main.ocombine)
            .assign(to: \.url, on: imageNode)
            .store(in: &cancellable)
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
