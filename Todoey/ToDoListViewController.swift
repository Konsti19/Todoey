//
//  ViewController.swift
//  Todoey
//
//  Created by Konstantin Poschlod on 29.01.19.
//  Copyright © 2019 Konstantin Poschlod. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = ["Buy apples","Buy milk","Buy fruits"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "ToDoList") as? [String]{
            itemArray = items
        }
    }

    // TableView DataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
 
    
    
   
//    TableView Delegates
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        }
    
//    Add new Items
    @IBAction func addItemButton(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add Item to TodoList", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item!", style: .default) { (action) in
          
            self.itemArray.append(textfield.text!)
            self.defaults.set(self.itemArray, forKey: "ToDoList")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Create new Item"
            textfield = alertTextfield
            
            
            print("Now")
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

