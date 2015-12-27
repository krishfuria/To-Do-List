//
//  SecondViewController.swift
//  To Do List
//
//  Created by Krish Furia on 12/26/15.
//  Copyright © 2015 Krish Furia. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var inputTextFiels: UITextField!
    
    @IBAction func addItemButton(sender: AnyObject) {
        confirmAdd(inputTextFiels.text!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.inputTextFiels.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Called when the user taps on the blank space on the screen
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true) //Close keyboard
    }
    
    //Called when the return key is pressed in the keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        inputTextFiels.resignFirstResponder() //Close the keyboard (keyboard is the firstResponder)
        return true
    }
    
    //Shows alert on the screen to add item to the To-Do List
    func confirmAdd (item: String){
        let alertAdd = UIAlertController(title: "Add Item", message: "Are you sure you want to add \(item) to the To-Do List?", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: handleOk)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: handleCancel)
        
        alertAdd.addAction(okAction)
        alertAdd.addAction(cancelAction)
        
        self.presentViewController(alertAdd, animated: true, completion: nil)
    }
    
    //Called when ok is pressed
    func handleOk(alertAction: UIAlertAction!) -> Void {
        toDoList.append(inputTextFiels.text!) //add to toDoList Array
        NSUserDefaults.standardUserDefaults().setObject(toDoList, forKey: "toDoList") //Store Permanently on the device
        inputTextFiels.text = ""
    }
    
    //Called when cancel is pressed
    func handleCancel(alertAction: UIAlertAction!) -> Void {
        inputTextFiels.text = "" //Clear the text field
    }


}

