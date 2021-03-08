//
//  SearchViewController.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2020/02/25.
//  Copyright © 2020 KIM JUNG HWAN. All rights reserved.
//

import AsyncDisplayKit
import OpenCombine
import DifferenceKit

final class SearchViewController: ASDKViewController<ASCollectionNode> {

    typealias ArraySection = SearchViewModel.Section
    
    private var collectionNode: ASCollectionNode {
        return self.node
    }
    
    override init() {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
        super.init(node: collectionNode)
    }
    
    var viewModel = SearchViewModel(title: "Welcome to Search")
    
    private var cancellable = Set<AnyCancellable>()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindings() {
        
        viewModel.$title
            .map { $0 }
            .receive(on: DispatchQueue.main.ocombine)
            .assign(to: \.title, on: self.navigationItem)
            .store(in: &cancellable)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .done, target: self, action: #selector(foo))
        self.bindings()
        
        self.collectionNode.delegate = self
        self.collectionNode.dataSource = self
    }
    
    @objc func foo() {
        fetchNewBatchWithContext(nil)
    }

    func fetchNewBatchWithContext(_ context: ASBatchContext?) {
        self.viewModel.title = "loading..."
        
        context?.beginBatchFetching()
        
        self.viewModel.fetch()
            .map { [ArraySection(model: .first, elements: $0.map { PhotoViewModel($0) })] }
            .receive(on: DispatchQueue.main.ocombine)
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
                
                self.collectionNode.reload(animated: true, using: changeSet) { [unowned self] data in
                    self.viewModel.data = data
                }
                
            })
            .store(in: &cancellable)
    }
}

extension SearchViewController: ASCollectionDataSource {
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        self.viewModel.data.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        self.viewModel.data[section].elements.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        let element = self.viewModel.data[indexPath.section].elements[indexPath.item]
        
        return { PhotoNode(element) }
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, willBeginBatchFetchWith context: ASBatchContext) {
        fetchNewBatchWithContext(context)
    }
}

extension SearchViewController: ASCollectionDelegate {
    
    func shouldBatchFetch(for collectionNode: ASCollectionNode) -> Bool {
        self.viewModel.data.isEmpty
    }
}
