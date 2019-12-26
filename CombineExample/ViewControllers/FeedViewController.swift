//
//  ASDKViewController.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2019/12/18.
//  Copyright © 2019 KIM JUNG HWAN. All rights reserved.
//

import AsyncDisplayKit
import OpenCombine
import OpenCombineDispatch
import OpenCombineFoundation

final class FeedViewController: ASViewController<ASTableNode> {
    
    var nodeModel = FeedNodeModel(title: "Welcome to Playground")
    
    var cancellable = [AnyCancellable]()
    
    override init() {
        super.init(node: ASTableNode())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }        
    
    func bindings() {
        nodeModel.$title
            .map { $0 }
            .receive(on: DispatchQueue.main.ocombine)
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
        
    }
    
    func fetchNewBatchWithContext(_ context: ASBatchContext?) {
        DispatchQueue.main.async {
            self.nodeModel.title = "loading..."
        }
        
        self.nodeModel.fetch()
            .receive(on: DispatchQueue.main.ocombine)
            .sink(receiveCompletion: { completion in
                print(".sink() received the completion", String(describing: completion))
                switch completion {
                case .finished:
                    self.node.reloadData {
                        self.nodeModel.title = "complete!"
                        context?.completeBatchFetching(true)
                    }
                    break
                case .failure(let anError):
                    self.nodeModel.title = "failure"
                    print("received error: ", anError)
                    context?.completeBatchFetching(true)
                }
            }, receiveValue: { someValue in
                print(".sink() received count =\(someValue.count)")
                self.nodeModel.photoNodeModels = someValue.compactMap { PhotoNodeModel($0) }
            })
            .store(in: &cancellable)
    }
}

extension FeedViewController: ASTableDataSource, ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return self.nodeModel.photoNodeModels.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let nodeModel: PhotoNodeModel = self.nodeModel.photoNodeModels[indexPath.row]
        let nodeBlock: ASCellNodeBlock = {
            PhotoNode(nodeModel)
        }
        return nodeBlock
    }
    
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        fetchNewBatchWithContext(context)
    }
}
