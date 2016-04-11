//
//  PostNaviViewController.swift
//  Mini Moment
//
//  Created by han xu on 2016-04-11.
//  Copyright © 2016 xhan91. All rights reserved.
//

import UIKit

class PostNaviViewController: UIViewController {

    
    @IBAction func tapToDismiss(sender: UITapGestureRecognizer) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
