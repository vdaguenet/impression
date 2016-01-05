//
//  RegisterViewController.swift
//  impression
//
//  Created by DAGUENET Valentin on 05/01/16.
//  Copyright © 2016 Arthur Valentin. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var birthdayField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var firstnameField: UITextField!
    
    var keyboardHeight: CGFloat!
    var keyboardVisible: Bool = false
    var needAnimation: Bool = false
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.firstnameField.delegate = self
        self.nameField.delegate = self
        self.emailField.delegate = self
        self.birthdayField.delegate = self
        self.passwordField.delegate = self
    }
    
    @IBAction func onFieldTouch(sender: AnyObject) {
        self.needAnimation = ((sender as! NSObject == self.birthdayField) || (sender as! NSObject == self.passwordField))
    }
    
    @IBAction func onFormSubmit(sender: AnyObject) {
        print("GO")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize =  (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                self.keyboardHeight = keyboardSize.height
                if (self.keyboardVisible == false && self.needAnimation == true) {
                    self.animateTextField(true)
                    self.keyboardVisible = true
                }
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if (self.keyboardVisible == true) {
            self.keyboardVisible = false
            self.animateTextField(false)
        }
    }
    
    func animateTextField(up: Bool) {
        let movement = (up ? -self.keyboardHeight : self.keyboardHeight)
        
        UIView.animateWithDuration(0.3, animations: {
            self.view.frame = CGRectOffset(self.view.frame, 0, movement)
        })
    }
}