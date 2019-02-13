//
//  ItemStore.swift
//  Shopping
//
//  Created by Shelan on 2/13/19.
//  Copyright © 2019 Shelan. All rights reserved.
//

import Foundation

class ItemStore {
    
    // declare 2 Items array in this array
    // 0 index refer to items on list, 1 index refer to purchased items
    var items = [[Item](), [Item]()]
    
    // add items method
    func add(_ item: Item, at index: Int, isDone: Bool = false) {
        
        // determines location of items
        let section = isDone ? 1 : 0
        
        items[section].insert(item, at: index)
    }
    
    // remove items
    @discardableResult func removeItem(at index: Int, isDone: Bool = false) -> Item {
        
        let section = isDone ? 1 : 0
        
        return items[section].remove(at: index)
    }
}
