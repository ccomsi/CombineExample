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

final class ASDKViewController: ASViewController<ASTableNode> {
    
    let viewModel = ViewModel(name: "KIM", age: 34)
    var counter: Int = 0
    var cancellable = [AnyCancellable]()
    
    @Published var username: String = "init"
    let myLabel: UILabel = UILabel()        
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        return UIActivityIndicatorView(style: .gray)
    }()
    
    init() {
        super.init(node: ASTableNode())
        self.navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .done, target: self, action: #selector(foo))
        
        let a = viewModel.$name.map { $0.lowercased() }
            .assign(to: \.title, on: self.navigationItem)
        
        let b = $username.compactMap { $0 }.sink { (someString) in
            print("value of username updated to: ", someString)
        }
        
        let c = $username
            .map { $0 }
            .assign(to: \.text, on: myLabel)
        
        cancellable.append(a)
        cancellable.append(b)
        cancellable.append(c)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func foo() {
        guard let tableView = self.view as? ASTableView  else { return }
        //tableView.tableNode?.reloadData()
        
        //fetchNewBatchWithContext(nil)
        viewModel.name = "haha"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        node.allowsSelection = false
        node.dataSource = self
        node.delegate = self
        node.leadingScreensForBatching = 2.5
        node.view.separatorStyle = .none
        
        navigationController?.hidesBarsOnSwipe = true
        
        node.view.addSubview(activityIndicatorView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      
        // Center the activity indicator view
        let bounds = node.bounds
        activityIndicatorView.frame.origin = CGPoint(
            x: (bounds.width - activityIndicatorView.frame.width) / 2.0,
            y: (bounds.height - activityIndicatorView.frame.height) / 2.0
        )
        //activityIndicatorView.center = self.node.view.center
        
//        activityIndicatorView.frame.origin = CGPoint(
//            x: (bounds.width - activityIndicatorView.frame.width) / 2.0,
//            y: (bounds.height - activityIndicatorView.frame.height) / 2.0
//        )
    }
    
    func fetchNewBatchWithContext(_ context: ASBatchContext?) {
        DispatchQueue.main.async {
            self.activityIndicatorView.startAnimating()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.activityIndicatorView.stopAnimating()
        }

//        photoFeedModel.updateNewBatchOfPopularPhotos() { additions, connectionStatus in
//            switch connectionStatus {
//            case .connected:
//                self.activityIndicatorView.stopAnimating()
//                self.addRowsIntoTableNode(newPhotoCount: additions)
//                context?.completeBatchFetching(true)
//            case .noConnection:
//                self.activityIndicatorView.stopAnimating()
//                context?.completeBatchFetching(true)
//            }
//        }
    }
}

extension ASDKViewController: ASTableDataSource, ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
//        let photo = photoFeedModel.itemAtIndexPath(indexPath)
        let nodeBlock: ASCellNodeBlock = {
//            return PhotoTableNodeCell(photoModel: photo)
            let cell = ASCellNode()
            
            return cell
        }
        return nodeBlock
    }
    
    func shouldBatchFetchForCollectionNode(collectionNode: ASCollectionNode) -> Bool {
        return true
    }
    
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        fetchNewBatchWithContext(context)
    }
}


