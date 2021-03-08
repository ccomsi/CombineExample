//
//  UserNode.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2020/02/25.
//  Copyright © 2020 KIM JUNG HWAN. All rights reserved.
//

import AsyncDisplayKit
import TextureSwiftSupport
import OpenCombine

final class UserNode: ASCellNode {
    
    let viewModel: UserViewModel
    
    private var cancellable = Set<AnyCancellable>()
    
    private lazy var nameNode: ASTextNode = {
        let node = ASTextNode()
        return node
    }()
    
    private lazy var userNameNode: ASTextNode = {
        let node = ASTextNode()
        return node
    }()
    
    private lazy var emailNode: ASTextNode = {
        let node = ASTextNode()
        return node
    }()
    
    init(_ viewModel: UserViewModel) {        
        self.viewModel = viewModel
        super.init()
        
        self.automaticallyManagesSubnodes = true
        self.binding()
    }
    
    private func binding() {
        
        viewModel.$name.map { NSAttributedString(string: $0) }
            .receive(on: DispatchQueue.main.ocombine)
            .assign(to: \.attributedText, on: nameNode)
            .store(in: &cancellable)
        
        viewModel.$userName.map { NSAttributedString(string: $0) }
            .receive(on: DispatchQueue.main.ocombine)
            .assign(to: \.attributedText, on: userNameNode)
            .store(in: &cancellable)
        
        viewModel.$email.map { NSAttributedString(string: $0) }
            .receive(on: DispatchQueue.main.ocombine)
            .assign(to: \.attributedText, on: emailNode)
            .store(in: &cancellable)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

        LayoutSpec {
            VStackLayout {
                nameNode
                userNameNode
                emailNode
            }.width(constrainedSize.max.width)
        }
    }
}
