//
//  LoginViewController.swift
//  impression
//
//  Created by DAGUENET Valentin on 05/01/16.
//  Copyright © 2016 Arthur Valentin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var connectBtn: UIButton!
    @IBOutlet weak var forgotPasswordBtn: UIButton!
    @IBOutlet weak var popin: UIVisualEffectView!
    @IBOutlet weak var popinView: UIView!
    @IBOutlet weak var popinButton: UIButton!
    @IBOutlet weak var popinTitle: UILabel!
    @IBOutlet weak var popinText: UILabel!
    
    var hasError: Bool = false
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Add shadow to popin
        self.popinView.layer.shadowColor = UIColor.blackColor().CGColor
        self.popinView.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.popinView.layer.shadowOpacity = 0.2
        self.popinView.layer.shadowRadius = 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailField.delegate = self
        self.passwordField.delegate = self
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    @IBAction func onFormSubmit(sender: AnyObject) {
        if (self.emailField.text! as String == "") {
            self.setPopupText("Erreur !", text: "Vous devez indiquer votre e-mail.")
            self.hasError = true
        } else if (self.passwordField.text! as String == "") {
            self.setPopupText("Erreur !", text: "Vous devez indiquer votre mot de passe.")
            self.hasError = true
        } else {
            self.setPopupText("Bienvenue !", text: "C'est une joie de vous revoir")
            self.hasError = false
        }
    }
    
    @IBAction func onForgotPasswordTouch(sender: AnyObject) {
        self.setPopupText("Confirmation", text: "Vous allez prochainement recevoir un e-mail pour modifier votre mot de passe.")
        self.hasError = true
    }
    
    @IBAction func closePopin(sender: AnyObject) {
        if (self.hasError == true) {
            self.popin.hidden = true
        }
    }
    
    private func setPopupText(title: String, text: String) {
        self.popinTitle.text = title
        self.popinText.text = text
        self.popin.hidden = false
    }
}
