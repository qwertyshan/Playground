//
//  ViewController.swift
//  MemeMeVer1
//
//  Created by Shantanu Rao on 10/29/15.
//  Copyright © 2015 Shantanu Rao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePicker: UIBarButtonItem!
    @IBOutlet weak var cameraPicker: UIBarButtonItem!
    @IBOutlet weak var textTop: UITextField!
    @IBOutlet weak var textBottom: UITextField!
    
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var imagePickerView: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        cameraPicker.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        setText(textTop)
        setText(textBottom)
    }
    
    // ************ TEXT FIELD STUFF ********************* //
    func setText(textfield: UITextField){
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : 1.0
        ]
        textfield.delegate = self
        textfield.textAlignment = NSTextAlignment.Center
        textfield.defaultTextAttributes = memeTextAttributes
        textfield.clearsOnBeginEditing = true
        switch textfield {
        case textTop:
            textfield.placeholder = "TOP"
        default:
            textfield.placeholder = "BOTTOM"
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.clearsOnBeginEditing {
            textField.text = ""
            textField.clearsOnBeginEditing = false
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        print("textFieldDidEndEditing")
        textField.resignFirstResponder()
    }
    
    //****************** KEYBOARD NOTIFICATIONS ********************//
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
    }
    
    var shiftUp = false
    
    func keyboardWillShow(notification: NSNotification) {
        if textBottom.isFirstResponder() && !shiftUp {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
            shiftUp = true
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if shiftUp {
            self.view.frame.origin.y += getKeyboardHeight(notification)
            shiftUp = false
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    //********* ACTION METHODS ******************//
    
    @IBAction func pickAnImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera (sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
 
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imagePickerView.image = image
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    struct Meme {
        var textTop: String
        var textBottom: String
        var image: UIImage
        var meme: UIImage
    }
    
    func save() {
        let memedImage = generateMemedImage()
        let meme = Meme(textTop: textTop.text!, textBottom: textBottom.text!, image: imagePickerView.image!, meme: memedImage)
    }
    
    func generateMemedImage() -> UIImage
    {
        toolbar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let meme : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        toolbar.hidden = false
        
        return meme
    }
    
}

