//
//  PostEditPageViewController.swift
//  Mini Moment
//
//  Created by han xu on 2016-04-14.
//  Copyright © 2016 xhan91. All rights reserved.
//

import UIKit
import Parse
import AVKit
import AVFoundation

class PostEditPageViewController: UIViewController {
    
    var type = ""
    var videoPath = ""
    var videoURL = NSURL()
    var photo = UIImage(named: "cat-background")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        assignBlurbackground(photo!, isBlur: true)
        
        extendedLayoutIncludesOpaqueBars = false
        edgesForExtendedLayout = .None

        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = doneButton
        
        view.addSubview(textView)
        textView.topAnchor.constraintEqualToAnchor(topLayoutGuide.topAnchor, constant: 16).active = true
        textView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 16).active = true
        textView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -16).active = true

        
        view.addSubview(contentView)
        
        contentView.topAnchor.constraintEqualToAnchor(textView.bottomAnchor, constant: 16).active = true
        contentView.centerXAnchor.constraintEqualToAnchor(textView.centerXAnchor).active = true
        contentView.heightAnchor.constraintEqualToAnchor(textView.heightAnchor).active = true
        contentView.widthAnchor.constraintEqualToAnchor(textView.widthAnchor).active = true
        contentView.bottomAnchor.constraintEqualToAnchor(bottomLayoutGuide.topAnchor, constant: -16).active = true

        
        switch type {
        case PostType.Say:
            break
        case PostType.Photo:
            contentView.addSubview(photoImageView)
            photoImageView.topAnchor.constraintEqualToAnchor(contentView.topAnchor).active = true
            photoImageView.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor).active = true
            photoImageView.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor).active = true
            photoImageView.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor).active = true
        case PostType.Video:
            let avPlayer = AVPlayer(URL: videoURL)
            let playerController = AVPlayerViewController()
            playerController.player = avPlayer
            playerController.view.frame = contentView.bounds
            self.contentView.addSubview(playerController.view)
//            avPlayer.play()
        default:
            break
        }
        
    }
    
    lazy var contentView: UIView = {
        let lazyContentView = UIView()
        lazyContentView.translatesAutoresizingMaskIntoConstraints = false
        lazyContentView.backgroundColor = UIColor.blackColor()
        return lazyContentView
    }()
    
    lazy var textView: UITextView = {
        let lazyTextView = UITextView()
        lazyTextView.translatesAutoresizingMaskIntoConstraints = false
        lazyTextView.layer.cornerRadius = 10
        lazyTextView.layer.borderColor = UIColor.lightGrayColor().CGColor
        lazyTextView.layer.borderWidth = 3
        return lazyTextView
    }()
    
    lazy var cancelButton: UIBarButtonItem = {
        let lazyCancelButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(cancelButtonPressed))
        return lazyCancelButton
    }()
    
    lazy var doneButton: UIBarButtonItem = {
        let lazyDoneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(doneButtonPressed))
        return lazyDoneButton
    }()
    
    lazy var photoImageView: UIImageView = {
        let lazyPhotoImageView = UIImageView()
        lazyPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        lazyPhotoImageView.contentMode = .ScaleAspectFit
        lazyPhotoImageView.image = self.photo
        lazyPhotoImageView.roundCornersForAspectFit(10)
        return lazyPhotoImageView
    }()
    
    @IBAction func doneButtonPressed() {
        let comment = textView.text
        switch type {
        case PostType.Say:
            let post = Post(comment: comment)
            post.saveInBackgroundWithBlock({ (success, error) in
                if success {
                    print("Upload a say post to server successfully")
                } else {
                    print(error)
                }
            })
        case PostType.Photo:
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
        case PostType.Video:
            if let videoData = NSData(contentsOfFile: videoPath),
                let videoFile = PFFile(data: videoData) {
                let post = Post(video: videoFile, comment: comment)
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
    
    @IBAction func cancelButtonPressed() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
