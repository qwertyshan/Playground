//
//  ViewController.swift
//  TextFieldDelegates
//
//  Created by Shantanu Rao on 10/27/15.
//  Copyright © 2015 Shantanu Rao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var mySwitch: UISwitch!
    
    let zipDelegate = ZipDelegate()
    let cashDelegate = CashDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the three delegates
        self.textField1.delegate = self.zipDelegate
        self.textField1.keyboardType = UIKeyboardType.NumberPad
        self.textField2.delegate = self.cashDelegate
        self.textField2.keyboardType = UIKeyboardType.NumberPad
        self.textField3.delegate = self
        
    }
    
    // Text Field Delegate
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return self.mySwitch.on
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    
    @IBAction func mySwitch(sender: AnyObject) {
        
        if !(sender as! UISwitch).on {
            self.textField3.resignFirstResponder()
        }
    }



}

