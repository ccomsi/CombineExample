//
//  ASDKViewController.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2019/12/18.
//  Copyright © 2019 KIM JUNG HWAN. All rights reserved.
//

import AsyncDisplayKit
import Combine
import DifferenceKit

final class FeedViewController: ASDKViewController<ASTableNode> {
    
    typealias ArraySection = FeedViewModel.Section

    private var tableNode: ASTableNode {
        return self.node
    }
    
    var viewModel = FeedViewModel(title: "Welcome to Playground")
    
    private var cancellable = Set<AnyCancellable>()
    
    override init() {
        super.init(node: ASTableNode())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }        
    
    private func bindings() {
        viewModel.$title
            .map { $0 }
            .receive(on: DispatchQueue.main)
            .assign(to: \.title, on: self.navigationItem)
            .store(in: &cancellable)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .done, target: self, action: #selector(foo))
        self.bindings()
        
        node.allowsSelection = false
        node.dataSource = self
        node.delegate = self
        node.view.separatorStyle = .none
    }
    
    @objc func foo() {
        fetchNewBatchWithContext(nil)
    }
    
    func fetchNewBatchWithContext(_ context: ASBatchContext?) {
        self.viewModel.title = "loading..."
        
        context?.beginBatchFetching()
        
        self.viewModel.fetch()
            .map {
                [ArraySection(model: .first, elements: $0.map { PostViewModel($0) })]
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [unowned self] completion in
                switch completion {
                case .finished:
                    self.viewModel.title = "complete!"
                case .failure(_):
                    self.viewModel.title = "failure"
                }
                
                context?.completeBatchFetching(true)
                
            }, receiveValue: { [unowned self] someValue in
                
                let changeSet = StagedChangeset(source: self.viewModel.data, target: someValue)
                self.tableNode.reload(using: changeSet, with: .none) { [unowned self] data in
                    self.viewModel.data = data
                }
            })
            .store(in: &cancellable)
    }
}

extension FeedViewController: ASTableDataSource {
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return self.viewModel.data.count
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.data[section].elements.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        let element = self.viewModel.data[indexPath.section].elements[indexPath.item]
                
        return { PostNode(element) }
    }
    
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        fetchNewBatchWithContext(context)
    }
}

extension FeedViewController: ASTableDelegate {
    
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        self.viewModel.data.isEmpty
    }
}
