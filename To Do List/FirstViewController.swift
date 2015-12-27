//
//  FirstViewController.swift
//  To Do List
//
//  Created by Krish Furia on 12/26/15.
//  Copyright © 2015 Krish Furia. All rights reserved.
//

import UIKit

var toDoList = [String]()

class FirstViewController: UIViewController, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    var toDoListDeleteIndex:Int = 0 //Index for deleting item for the array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Check if todolist array exist
        if NSUserDefaults.standardUserDefaults().objectForKey("toDoList") != nil {
            toDoList = NSUserDefaults.standardUserDefaults().objectForKey("toDoList") as! [String]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Setting the number of row in the Table View
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return toDoList.count
    }
    
    //Setting content of the Table View
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        cell.textLabel?.text = toDoList[indexPath.row]
        return cell
    }
    
    //Called when table cell has been tried to edit (delete for example)
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            toDoListDeleteIndex = indexPath.row
            confirmDelete(toDoList[toDoListDeleteIndex])
            
        }
    }
    
    func confirmDelete(item: String) {
        let alert = UIAlertController(title: "Delete Item", message: "Are you sure you want to permanently delete \(item)?", preferredStyle: .ActionSheet)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: handleDeleteItem)
        let CancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: cancelDeleteItem)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //Called when Delete button is pressed
    func handleDeleteItem(alertAction: UIAlertAction!) -> Void {
        toDoList.removeAtIndex(toDoListDeleteIndex)
        NSUserDefaults.standardUserDefaults().setObject(toDoList, forKey: "toDoList")
        tableView.reloadData()
    }
    
    //Called when Cancel button is pressed
    func cancelDeleteItem(alertAction: UIAlertAction!) -> Void {
        toDoListDeleteIndex = 0
    }
    
    //Function called when the view appears
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }

}

