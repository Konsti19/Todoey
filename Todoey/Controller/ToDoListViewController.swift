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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        loadItems()
    }

    // TableView DataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
    }
    
 
    
    
   
//    TableView Delegates
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        }
    
//    Add new Items with alert-function
    @IBAction func addItemButton(_ sender: UIBarButtonItem) {
        //Global Variable
        var textfield = UITextField()
        //Action-Alert
        let alert = UIAlertController(title: "Add Item to TodoList", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item!", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textfield.text!
            
            self.itemArray.append(newItem)
            
            self.saveItems()
        }
        
            alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Create new Item"
            textfield = alertTextfield
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
//    new save-function
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding data")
        }
        self.tableView.reloadData()
    }
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            
            do {
                let itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding data")
            }
    }
}

}
