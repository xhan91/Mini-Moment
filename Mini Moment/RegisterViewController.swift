//
//  RegisterViewController.swift
//  Mini Moment
//
//  Created by han xu on 2016-04-10.
//  Copyright © 2016 xhan91. All rights reserved.
//

import UIKit
import Parse

class RegisterViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var nickyNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setTextField(usernameTextField)
        setTextField(passwordTextField)
        setTextField(confirmPasswordTextField)
        setTextField(nickyNameTextField)
    }
    
    func setTextField (textField: UITextField) {
        textField.layer.borderColor = UIColor.whiteColor().CGColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.textColor = UIColor.whiteColor()
    }
    
    @IBAction func registerButtonPressed(sender: UIButton) {
        if let username = usernameTextField.text,
            let nickyName = nickyNameTextField.text,
            let password = passwordTextField.text,
            let confirmPassword = confirmPasswordTextField.text
            where password == confirmPassword && !(username == "" || password == "" || nickyName == "") {
            let user = PFUser()
            user.username = username
            user.password = password
            user["nickyName"] = nickyName
            user.signUpInBackgroundWithBlock({ (success, error) in
                if success {
                    print("successfully sign \(username) up")
                    let prefs: NSUserDefaults = NSUserDefaults.standardUserDefaults()
                    prefs.setObject(username, forKey: "USERNAME")
                    prefs.setObject(password, forKey: "PASSWORD")
                    prefs.synchronize()
                    let alert = UIAlertController(title: "Congratulations!", message: "Welcome, \(nickyName), start to enjoy your Moments", preferredStyle: .Alert)
                    let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: { action in
                        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
                    })
                    alert.addAction(okAction)
                    self.presentViewController(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Oops!", message: "Did not register successfully, maybe try again?", preferredStyle: .Alert)
                    let okAction = UIAlertAction(title: "OK", style: .Default) { _ in
                        self.passwordTextField.text = ""
                        self.confirmPasswordTextField.text = ""
                    }
                    alert.addAction(okAction)
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            })
        } else {
            let alert = UIAlertController(title: "Sorry", message: "Please confirm all information are correct", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default) { _ in
                self.passwordTextField.text = ""
                self.confirmPasswordTextField.text = ""
            }
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func haveAccountButtonPressed(sender: UIButton) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
