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
    
    func addButton() {
        let button = UIButton(type: UIButtonType.System) as UIButton
        let image = UIImage(named: "task-icon-post")!
        button.frame = CGRectMake(0, 0, image.size.height, image.size.width)
        button.backgroundColor = UIColor.blackColor()
        button.layer.cornerRadius = 25
        button.setBackgroundImage(image, forState: UIControlState.Normal)
        //button.setTitle("Test", forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(TabBarViewController.buttonAction), forControlEvents: UIControlEvents.TouchUpInside)
        let center = self.tabBar.center
        button.center = center
        self.view.addSubview(button)
    }
    
    func buttonAction() {
        print("a")
    }
}
