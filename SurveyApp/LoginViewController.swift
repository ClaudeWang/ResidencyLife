//
//  LoginViewController.swift
//  SurveyApp
//
//  Created by Ziyun Wang on 8/29/16.
//  Copyright © 2016 Ziyun Wang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBAction func loginCheck(sender: AnyObject) {
        if (hashCheck(emailTextField.text!)){
            //perform segue and store the hash to local.
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setValue(emailTextField.text, forKey: "ID")
            defaults.synchronize()
            self.performSegueWithIdentifier("loginToInfo", sender: self)
        }
        else {
            //alert to ask for re-input.
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        //add keyboard dismiss
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        //check if already logged in.
        let defaults = NSUserDefaults.standardUserDefaults()
        let id = defaults.stringForKey("ID")
        if (id != nil) {
            //self.performSegueWithIdentifier("loginToInfo", sender: self)
            self.performSegueWithIdentifier("loginToStart", sender: self)
        }
    }
    func hashCheck(text:String)->Bool {
        return true;
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
