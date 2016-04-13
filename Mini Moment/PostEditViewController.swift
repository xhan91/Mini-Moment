//
//  PostEditViewController.swift
//  Mini Moment
//
//  Created by han xu on 2016-04-12.
//  Copyright © 2016 xhan91. All rights reserved.
//

import UIKit

class PostEditViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var commentTextField: UITextView!
    var type = ""
    var videoPath = ""
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch type {
        case "say":
            break
        case "photo":
            break
        case "video":
            break
        default:
            break
        }
    }
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        
    }
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        self.presentedViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
