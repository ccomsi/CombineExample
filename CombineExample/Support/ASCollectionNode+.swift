//
//  ASCollectionNode+.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2021/03/08.
//  Copyright © 2021 KIM JUNG HWAN. All rights reserved.
//

import DifferenceKit
import AsyncDisplayKit

public extension ASCollectionNode {

    /// Applies multiple animated updates in stages using `StagedChangeset`.
    /// - Parameters:
    ///   - stagedChangeset: A staged set of changes.
    ///   - interrupt: A closure that takes an changeset as its argument and returns `true` if the animated updates should be stopped and performed reloadData. Default is nil.
    ///   - setData: A closure that takes the collection as a parameter. The collection should be set to data-source of UICollectionView.
    func reload<C>(animated: Bool,
                   using stagedChangeset: StagedChangeset<C>,
                   interrupt: ((Changeset<C>) -> Bool)? = nil,
                   setData: (C) -> Void,
                   completion: (() -> Void)? = nil) {
                
        let previousContentOffset = self.contentOffset
        
        let group = DispatchGroup()
        group.notify(queue: .main) { [weak self] in
            guard let unwrappedSelf = self else { return }

            let offset = CGPoint(x: previousContentOffset.x,
                                 y: min(previousContentOffset.y, max(0, unwrappedSelf.view.contentSize.height - unwrappedSelf.bounds.height + unwrappedSelf.contentInset.bottom)))
            unwrappedSelf.setContentOffset(offset, animated: false)
            
            CATransaction.commit()
            completion?()
        }
        group.enter()
        defer { group.leave() }
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        for changeset in stagedChangeset {
            if let interrupt = interrupt, interrupt(changeset), let data = stagedChangeset.last?.data {
                setData(data)
                return reloadData()
            }
            
            group.enter()
            
            performBatch(animated: animated, updates: {
                setData(changeset.data)
                
                if !changeset.sectionDeleted.isEmpty {
                    deleteSections(IndexSet(changeset.sectionDeleted))
                }
                
                if !changeset.sectionInserted.isEmpty {
                    insertSections(IndexSet(changeset.sectionInserted))
                }
                
                if !changeset.sectionUpdated.isEmpty {
                    reloadSections(IndexSet(changeset.sectionUpdated))
                }
                
                for (source, target) in changeset.sectionMoved {
                    moveSection(source, toSection: target)
                }
                
                if !changeset.elementDeleted.isEmpty {
                    deleteItems(at: changeset.elementDeleted.map { IndexPath(item: $0.element, section: $0.section) })
                }
                
                if !changeset.elementInserted.isEmpty {
                    insertItems(at: changeset.elementInserted.map { IndexPath(item: $0.element, section: $0.section) })
                }
                
                if !changeset.elementUpdated.isEmpty {
                    reloadItems(at: changeset.elementUpdated.map { IndexPath(item: $0.element, section: $0.section) })
                }
                
                for (source, target) in changeset.elementMoved {
                    moveItem(at: IndexPath(item: source.element, section: source.section), to: IndexPath(item: target.element, section: target.section))
                }
                                
            }, completion: { _ in
                group.leave()
            })
        }
    }
}

