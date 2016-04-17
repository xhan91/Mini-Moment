//
//  PostNaviViewController.swift
//  Mini Moment
//
//  Created by han xu on 2016-04-11.
//  Copyright © 2016 xhan91. All rights reserved.
//

import UIKit
import Parse
import MobileCoreServices

class PostNaviViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var sayButton: UIButton!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var movieButton: UIButton!
    
    var newMedia = true
    var type = ""
    var photo = UIImage()
    var videoPath = ""
    var videoURL = NSURL()
    var willShowAnimate = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sayButton.alpha = 0.0
        photoButton.alpha = 0.0
        movieButton.alpha = 0.0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if willShowAnimate {
            showAnimate()
            willShowAnimate = false
        }
    }
    
    func showAnimate() {
        let buttons = [sayButton, photoButton, movieButton]
        for button in buttons {
            button.transform = CGAffineTransformMakeScale(1.3, 1.3)
            UIView.animateWithDuration(0.5, animations: {
                button.alpha = 1.0
                button.transform = CGAffineTransformMakeScale(1.0, 1.0)
            })
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
    
    @IBAction func sayButtonPressed(sender: UIButton) {
        type = "say"
        performSegueWithIdentifier("postNaviGoToPostEdit", sender: self)
    }
    
    @IBAction func photoButtonPressed(sender: UIButton) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .Default) { (action) -> Void in
            self.setMediaSource("photo", source:"Camera")
        }
        let libraryAction = UIAlertAction(title: "Library", style: .Default) { (action) -> Void in
            self.setMediaSource("photo", source:"Library")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cameraAction)
        alertController.addAction(libraryAction)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func movieButtonPressed(sender: AnyObject) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .Default) { (action) -> Void in
            self.setMediaSource("video", source:"Camera")
        }
        let libraryAction = UIAlertAction(title: "Library", style: .Default) { (action) -> Void in
            self.setMediaSource("video", source:"Library")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cameraAction)
        alertController.addAction(libraryAction)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func setMediaSource(type: String, source: String) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        switch source {
        case "Camera":
            pickerController.sourceType = .Camera
            pickerController.cameraDevice = .Rear
            pickerController.cameraCaptureMode = .Photo
            newMedia = true
        case "Library":
            pickerController.sourceType = .SavedPhotosAlbum
            newMedia = false
        default:
            break
        }
        switch type {
        case "photo":
            pickerController.mediaTypes = [kUTTypeImage as String]
            self.type = "photo"
        case "video":
            pickerController.mediaTypes = [kUTTypeMovie as String]
            pickerController.videoMaximumDuration = 120 // Perhaps reduce 180 to 120
            pickerController.videoQuality = UIImagePickerControllerQualityType.TypeMedium
            self.type = "video"
        default:
            break
        }
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if type == "photo" {
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            if newMedia == true {
                UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
            }
            self.photo = image
            performSegueWithIdentifier("postNaviGoToPostEdit", sender: self)
        } else if type == "video" {
            let videoURL = info[UIImagePickerControllerMediaURL] as! NSURL
            if let videoPath = videoURL.relativePath {
                if newMedia == true {
                    UISaveVideoAtPathToSavedPhotosAlbum(videoPath, self, nil, nil)
                }
                self.videoPath = videoPath
                self.videoURL = videoURL
                performSegueWithIdentifier("postNaviGoToPostEdit", sender: self)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController.contentViewController as? PostEditViewController {
            destination.type = type
            switch type {
            case "photo":
                destination.photo = self.photo
            case "video":
                destination.videoPath = self.videoPath
                destination.videoURL = self.videoURL
            default:
                break
            }
        }
    }

}
