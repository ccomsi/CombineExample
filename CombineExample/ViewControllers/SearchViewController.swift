//
//  SearchViewController.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2020/02/25.
//  Copyright © 2020 KIM JUNG HWAN. All rights reserved.
//

import AsyncDisplayKit
import IGListKit
import OpenCombine
import OpenCombineDispatch

final class SearchViewController: ASDKViewController<ASCollectionNode> {
    
    var adapter: ListAdapter!
    var collectionNode: ASCollectionNode {
        return self.node
    }
    
    var data: [ListDiffable] = []
    
    override init() {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
        super.init(node: collectionNode)
        self.adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
        self.adapter.dataSource = self
        self.adapter.setASDKCollectionNode(collectionNode)
    }
    
    var nodeModel = SearchNodeModel(title: "Welcome to Search")
    
    var cancellable = Set<AnyCancellable>()
    
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
    }
    
    @objc func foo() {
        
        DispatchQueue.main.async {
            self.nodeModel.title = "loading..."
        }
        
        self.nodeModel.fetch()            
            .map { $0.map { PhotoNodeModel($0) } } // [Photo] to [PhotoNodeModel]
            .map { PhotoSection($0) } // [PhotoNodeModel] to PhotoSection
            .receive(on: DispatchQueue.main.ocombine)
            .sink(receiveCompletion: { completion in
                print(".sink() received the completion", String(describing: completion))
                switch completion {
                case .finished:
                    self.adapter.performUpdates(animated: true, completion: { [weak self] _ in
                        self?.nodeModel.title = "complete!"
                    })
                case .failure(let anError):
                    self.nodeModel.title = "failure"
                    self.adapter.performUpdates(animated: true, completion: nil)
                    print("received error: ", anError)
                }
            }, receiveValue: { someValue in
                self.data = [someValue]
            })
            .store(in: &cancellable)
    }

}

extension SearchViewController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        
        return self.data
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        switch object {
        case is PhotoSection:
            return PhotoSectionController()
        default:
            assert(false, "missing case")
            return ListSectionController()
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { nil }
}
