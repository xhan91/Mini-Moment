//
//  FriendViewController.swift
//  Mini Moment
//
//  Created by han xu on 2016-04-16.
//  Copyright © 2016 xhan91. All rights reserved.
//

import UIKit

class FriendViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func test(sender: UIButton) {
        let pepVC = PostEditPageViewController()
        let navVC = UINavigationController(rootViewController: pepVC)
        presentViewController(navVC, animated: true, completion: nil)
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
