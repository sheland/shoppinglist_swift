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
    
    var itemStore: ItemStore!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        // set up alert controller
        let alertController = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
        
        // set up the actions
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            
            //grab text field text
            guard let name = alertController.textFields?.first?.text else { return }
            
            //create item
            let newItem = Item(name: name)
            
            //add item
            self.itemStore.add(newItem, at: 0)
            
            //reload data in table view
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
            
        }
        
        addAction.isEnabled = false
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        // add the text field
        alertController.addTextField { textField in
            textField.placeholder = "Enter item"
            textField.addTarget(self, action: #selector(self.handleTextChanged), for: .editingChanged)
                
        }
        
        // add the actions
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        // present
        present(alertController, animated: true)
    }
    
    @objc private func handleTextChanged(_sender: UITextField){
        //grab the alert controller & add action
        //translation-> if you can grab alert controller, addAction, text...proceed, or go to else block
        guard let alertController = presentedViewController as? UIAlertController,
            let addAction = alertController.actions.first,
            let text = _sender.text
            else { return }
        
        //enable add action based if text is empty or contains whitespace
        //translation-> after we trim beginning & ending of string, if empty, return true (disable add button)
        addAction.isEnabled = !text.trimmingCharacters(in: .whitespaces).isEmpty
        
    }
}

// MARK: - DataSource
extension ShoppingController {
    
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
//        return section == 0 ? "Items" : "Purchased"
        return "Items"
    }
    
    //return 2 sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return itemStore.items.count
    }
    
    //returns row
    //controller controlling the table view, not directly dealing w/ model data
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.items[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = itemStore.items[indexPath.section][indexPath.row].name
        return cell
    }
    
    
}

// MARK -Delegate
extension ShoppingController {
    
    //rightswipe
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (action, sourceview, completedHandler) in
            
            //determine whether item 'isDone'
            let isDone = self.itemStore.items[indexPath.section][indexPath.row].isDone
            
            //remove the item from appropriate array
            self.itemStore.removeItem(at: indexPath.row, isDone: isDone)
            
            //reload table view
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            //indicate if action was performed
            completedHandler(true)
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.05650175749, blue: 0.2285120078, alpha: 1)
        deleteAction.title = "delete"
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
        
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let doneAction = UIContextualAction(style: .normal, title: nil) { (action, sourceView, completionHandler) in
            
            //toggle that item is done
            self.itemStore.items[0][indexPath.row].isDone = true
            
            //remove the item from array
            let doneItem = self.itemStore.removeItem(at: indexPath.row)
            
            
            //reload table view
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            //add the item to purchased array
            self.itemStore.add(doneItem, at: 0, isDone: true)
            
            //reload table view
            tableView.insertRows(at: [IndexPath.init(row: 0, section: 1)], with: .automatic)
            
            
            //indicate the action was performed
            completionHandler(true)
        }
        
        doneAction.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        doneAction.title = "done"
        
        return UISwipeActionsConfiguration(actions: [doneAction])
    }
}
