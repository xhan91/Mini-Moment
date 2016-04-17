//
//  TabBarViewController.swift
//  Mini Moment
//
//  Created by han xu on 2016-04-10.
//  Copyright © 2016 xhan91. All rights reserved.
//

import UIKit
import Parse

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if let _ = PFUser.currentUser() {
        } else {
            checkLogInStatus()
        }
    }
    
    func checkLogInStatus() {
        let prefs: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if let username = prefs.stringForKey("USERNAME"),
            let password = prefs.stringForKey("PASSWORD") {
            PFUser.logInWithUsernameInBackground(username, password: password) { (user, error) in
                if let username = user?.username {
                    print("successfully logged in as \(username)")
                } else {
                    let loginVC = self.storyboard!.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
                    self.presentViewController(loginVC, animated: true, completion: nil)
                }
            }
        } else {
            let loginVC = self.storyboard!.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
            self.presentViewController(loginVC, animated: true, completion: nil)
        }
    }
    
    func addButton() {
        let button = UIButton(type: UIButtonType.System) as UIButton
        let image = UIImage(named: "plus_button")!
        button.frame = CGRectMake(0, 0, image.size.width, image.size.height)
        button.backgroundColor = UIColor.lightGrayColor()
        button.setBackgroundImage(image, forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(TabBarViewController.buttonAction), forControlEvents: UIControlEvents.TouchUpInside)
        let center = self.tabBar.center
        button.center = center
        self.view.addSubview(button)
    }
        
 
    
    func buttonAction() {
        let postNavVC = self.storyboard!.instantiateViewControllerWithIdentifier("PostNaviViewController") as! PostNaviViewController
        postNavVC.modalPresentationStyle = .OverFullScreen
        presentViewController(postNavVC, animated: false, completion: nil)
    }
}
