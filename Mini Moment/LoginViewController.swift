//
//  LogInViewController.swift
//  Mini Moment
//
//  Created by han xu on 2016-04-10.
//  Copyright © 2016 xhan91. All rights reserved.
//

import UIKit
import Parse
import QuartzCore

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextField(usernameTextField)
        setTextField(passwordTextField)
        self.hideKeyboardWhenTappedAround()
    }
    
    func setTextField (textField: UITextField) {
        textField.layer.borderColor = UIColor.whiteColor().CGColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.textColor = UIColor.whiteColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        if let _ = PFUser.currentUser() {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func LogInButtonPressed(sender: UIButton) {
        if let username = usernameTextField.text,
            let password = passwordTextField.text {
            PFUser.logInWithUsernameInBackground(username, password: password) { (user, error) in
                if let _ = user {
                    let prefs: NSUserDefaults = NSUserDefaults.standardUserDefaults()
                    prefs.setObject(username, forKey: "USERNAME")
                    prefs.setObject(password, forKey: "PASSWORD")
                    prefs.synchronize()
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    self.passwordTextField.text = ""
                    let alert = UIAlertController(title: "Login failed", message: nil, preferredStyle: .Alert)
                    let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                    alert.addAction(okAction)
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
