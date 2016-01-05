//
//  ChooseLoginViewController.swift
//  impression
//
//  Created by DAGUENET Valentin on 04/01/16.
//  Copyright © 2016 Arthur Valentin. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import TwitterKit


class ChooseLoginViewController: UIViewController {
    @IBOutlet weak var facebookLoginBtn: UIButton!
    @IBOutlet weak var twitterLoginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backFromRegisterView(segue: UIStoryboardSegue) {}

    @IBAction func twLoginTouch(sender: AnyObject) {
        Twitter.sharedInstance().logInWithCompletion { session, error in
            if (session != nil) {
                if let userID = Twitter.sharedInstance().sessionStore.session()!.userID {
                    let twClient = TWTRAPIClient(userID: userID)
                    twClient.loadUserWithID(userID) { (user, err) -> Void in
                        if (err != nil) {
                            print("[TW Login] Error \(err)")
                        } else {
                            print("[TW Login] Logged in")
                            self.saveUser((user?.name)! as String, lastName: "", email: "")
                        }
                    }
                }
            } else {
                print("[TW Login] Error \(error!.localizedDescription)");
            }
        }
    }
    
    @IBAction func fbLoginTouch(sender: AnyObject) {
        let fbLoginManager = FBSDKLoginManager();
        fbLoginManager.logInWithReadPermissions(["public_profile", "email"], fromViewController: self) { (result: FBSDKLoginManagerLoginResult!, error: NSError!) -> Void in
            if (error != nil) {
                print("[FB Login] Process error");
            } else if (result.isCancelled) {
                print("[FB Login] Cancelled");
            } else {
                print("[FB Login] Logged in");
                self.getFBUserData()
            }
        }
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                if (error == nil){
                    let fbUserData = result as! NSDictionary
                    
                    self.saveUser(fbUserData.objectForKey("first_name") as! String, lastName: fbUserData.objectForKey("last_name") as! String, email: fbUserData.objectForKey("email") as! String)
                    
                }
            })
        }
    }
    
    private func saveUser(firstName: String, lastName: String, email: String) {
//        This is for the demo. For a real registration we must check if user already exist in database, save the user, etc.
        print("[Login] User registered")
        print("name: \(firstName) \(lastName)")
        print("email: \(email)")
    }
}
