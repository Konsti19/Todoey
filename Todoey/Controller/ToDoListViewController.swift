//
//  ViewController.swift
//  Todoey
//
//  Created by Konstantin Poschlod on 29.01.19.
//  Copyright © 2019 Konstantin Poschlod. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Eggs"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destroy Me"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "ToDoList") as? [Item]{
        itemArray = items
        }
    }

    // TableView DataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
    }
    
 
    
    
   
//    TableView Delegates
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        }
    
//    Add new Items
    @IBAction func addItemButton(_ sender: UIBarButtonItem) {
        //Global Variable
        var textfield = UITextField()
        //Action-Alert
        let alert = UIAlertController(title: "Add Item to TodoList", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item!", style: .default) { (action) in
            let newItem = Item()
            newItem.title = textfield.text!
            
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "ToDoList")
            self.tableView.reloadData()
        }
        
            alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Create new Item"
            textfield = alertTextfield
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

