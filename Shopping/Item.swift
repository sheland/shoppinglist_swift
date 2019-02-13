//
//  Item.swift
//  Shopping
//
//  Created by Shelan on 2/13/19.
//  Copyright © 2019 Shelan. All rights reserved.
//

import Foundation

class Item {
    
    //variables
    var name: String
    var isDone: Bool
    
    //initializer for class, set up objects
    init(name: String, isDone: Bool = false) {
        self.name = name
        self.isDone = isDone
    }
}
