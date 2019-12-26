//
//  PhotoSectionController.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2020/02/25.
//  Copyright © 2020 KIM JUNG HWAN. All rights reserved.
//

import IGListKit
import AsyncDisplayKit
import Foundation

final class PhotoSectionController: ListSectionController, ASSectionController {
    
    var items: [PhotoNodeModel]?
    
    override func didUpdate(to object: Any) {
        
        if let object = object as? PhotoSection {
            self.items = object.items
        }
    }
    
    override func numberOfItems() -> Int {
        
        return items?.count ?? 0
    }
    
    func nodeBlockForItem(at index: Int) -> ASCellNodeBlock {
        
        guard self.items?.isEmpty == false, let nodeModel = self.items?[index] else { return { ASCellNode() } }
                
        return { PhotoNode(nodeModel) }
        
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        
      let size = ASIGListSectionControllerMethods.sizeForItem(at: index)
      return size
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
      let cell = ASIGListSectionControllerMethods.cellForItem(at: index, sectionController: self)
      return cell
    }
    
}
