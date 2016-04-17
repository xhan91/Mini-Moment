//
//  PostEditViewController.swift
//  Mini Moment
//
//  Created by han xu on 2016-04-12.
//  Copyright © 2016 xhan91. All rights reserved.
//

import UIKit
import Parse
import AVFoundation
import AVKit

class PostEditViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var commentTextField: UITextView!
    
    var type = ""
    var videoPath = ""
    var videoURL = NSURL()
    var photo = UIImage(named: "cat-background")
    var needToLayout = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.layoutIfNeeded() // hack to run autolayout engine immediately
        
        hideKeyboardWhenTappedAround()
        assignBlurbackground(photo!, isBlur: true)
        contentView.backgroundColor = UIColor.clearColor()
        commentTextField.layer.cornerRadius = 10
        commentTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        commentTextField.layer.borderWidth = 3
    }

    override func viewDidLayoutSubviews() {
        if needToLayout {
            displayInContentView()
            needToLayout = false
        }
    }
    
    func displayInContentView() {
        switch type {
        case "say":
            break
        case "photo":
            let photoImageView = UIImageView(frame: CGRectMake(0, 0, contentView.bounds.width, contentView.bounds.height))
//            photoImageView.layer.borderWidth = 3
//            photoImageView.layer.borderColor = UIColor.blueColor().CGColor
            photoImageView.contentMode = .ScaleAspectFit
            photoImageView.image = photo
            photoImageView.roundCornersForAspectFit(10)
            self.contentView.addSubview(photoImageView)
        case "video":
            let avPlayer = AVPlayer(URL: videoURL)
            let playerController = AVPlayerViewController()
            playerController.player = avPlayer
            playerController.view.frame = contentView.bounds
            self.contentView.addSubview(playerController.view)
            avPlayer.play()
        default:
            break
        }

    }
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        let comment = commentTextField.text
        switch type {
        case "say":
            let post = Post(comment: comment)
            post.saveInBackgroundWithBlock({ (success, error) in
                if success {
                    print("Upload a say post to server successfully")
                } else {
                    print(error)
                }
            })
        case "photo":
            if let photo = photo,
                let photoData = UIImageJPEGRepresentation(photo, 0.2),
                let photoFile = PFFile(data: photoData) {
                let post = Post(photo: photoFile, comment: comment)
                post.saveInBackgroundWithBlock({ (success, error) in
                    if success {
                        print("Upload a photo post to server successfully")
                    } else {
                        print(error)
                    }
                })
            }
        case "video":
            if let videoData = NSData(contentsOfFile: videoPath),
                let videoFile = PFFile(data: videoData) {
                let post = Post(video: videoFile, comment: comment)
                print("go go")
                post.saveInBackgroundWithBlock({ (success, error) in
                    if success {
                        print("Upload a video post to server successfully")
                    } else {
                        print(error)
                    }
                })
            }
        default:
            break
        }
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
