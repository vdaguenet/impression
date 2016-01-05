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
    @IBOutlet weak var popin: UIVisualEffectView!
    @IBOutlet weak var popinView: UIView!
    @IBOutlet weak var popinTitle: UILabel!
    @IBOutlet weak var popinText: UILabel!
    @IBOutlet weak var popinBtn: UIButton!
    
    var keyboardHeight: CGFloat!
    var keyboardVisible: Bool = false
    var needAnimation: Bool = false
    var hasError: Bool = false
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
        
        // Add shadow to popin
        self.popinView.layer.shadowColor = UIColor.blackColor().CGColor
        self.popinView.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.popinView.layer.shadowOpacity = 0.2
        self.popinView.layer.shadowRadius = 10
        
        // Add events for keyboard
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
        let err = self.checkForm()
       
        if (err != "") {
            self.hasError = true
            self.popinBtn.setTitle("R É E S S A Y E R", forState: UIControlState.Normal)
            self.setPopupText("Erreur !", text: err)
        } else {
            self.hasError = false
            self.popinBtn.setTitle("O K", forState: UIControlState.Normal)
            self.setPopupText("Félicitations !", text: "Votre compte Sisley a bien été créé, bienvenue \(self.firstnameField.text! as String).")
        }
        
    }
    
    @IBAction func closePopin(sender: AnyObject) {
        if (self.hasError == true) {
            self.popin.hidden = true
        }
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
    
    private func checkForm() -> String {
        if (self.firstnameField.text! as String == "") {
            return "Vous devez indiquer votre prénom."
        }
        if (self.nameField.text! as String == "") {
            return "Vous devez indiquer votre nom de famille."
        }
        if (self.emailField.text! as String == "") {
            return "Vous devez indiquer votre e-mail."
        }
        if (self.birthdayField.text! as String == "") {
            return "Vous devez indiquer votre date de naissance."
        }
        if (self.passwordField.text! as String == "") {
            return "Vous devez indiquer votre mot de passe."
        }
        
        return ""
    }
    
    private func setPopupText(title: String, text: String) {
        self.popinTitle.text = title
        self.popinText.text = text
        self.popin.hidden = false
    }
}