//
//  PostNaviViewController.swift
//  Mini Moment
//
//  Created by han xu on 2016-04-11.
//  Copyright © 2016 xhan91. All rights reserved.
//

import UIKit

class PostNaviViewController: UIViewController {

    @IBOutlet weak var sayButton: UIButton!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var movieButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sayButton.alpha = 0.0
        photoButton.alpha = 0.0
        movieButton.alpha = 0.0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        showAnimate()
    }
    
    func showAnimate() {
        let buttons = [sayButton, photoButton, movieButton]
        for button in buttons {
            button.transform = CGAffineTransformMakeScale(1.3, 1.3)
            button.alpha = 0.0;
            UIView.animateWithDuration(0.5, animations: {
                button.alpha = 1.0
                button.transform = CGAffineTransformMakeScale(1.0, 1.0)
            })
            button.alpha = 1.0
        }
    }
    
    func dismissAnimate() {
        let buttons = [sayButton, photoButton, movieButton]
        UIView.animateWithDuration(0.5, animations: {
            for button in buttons {
                button.alpha = 0.0
                button.transform = CGAffineTransformMakeScale(1.3, 1.3)
            }
            }) { (_) in
                self.presentingViewController?.dismissViewControllerAnimated(false, completion: nil)
        }
    }
    
    @IBAction func tapToDismiss(sender: UITapGestureRecognizer) {
        dismissAnimate()
    }
    
}
