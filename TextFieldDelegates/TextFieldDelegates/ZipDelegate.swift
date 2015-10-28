//
//  ZipDelegate.swift
//  TextFieldDelegates
//
//  Created by Shantanu Rao on 10/27/15.
//  Copyright © 2015 Shantanu Rao. All rights reserved.
//

import Foundation
import UIKit

class ZipDelegate: NSObject, UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        // Figure out what the new text will be, if we return true
        var newText: NSString = textField.text!
        newText = newText.stringByReplacingCharactersInRange(range, withString: string)
        
        return String(newText).containsOnlyCharactersIn("0123456789") && String(newText).characters.count <= 5
    }

}