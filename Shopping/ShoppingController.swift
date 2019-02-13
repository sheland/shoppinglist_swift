//
//  ShoppingController.swift
//  Shopping
//
//  Created by Shelan on 2/13/19.
//  Copyright © 2019 Shelan. All rights reserved.
//

import UIKit

//what data we see
class ShoppingController: UITableViewController {
    
    
    
}

// MARK: - DataSource
extension ShoppingController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Task"
        return cell
    }
    
}
