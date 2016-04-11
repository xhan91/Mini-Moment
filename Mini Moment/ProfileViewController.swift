//
//  ProfileViewController.swift
//  Mini Moment
//
//  Created by han xu on 2016-04-08.
//  Copyright © 2016 xhan91. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var numberOfSaysLabel: UILabel!
    @IBOutlet weak var numberOfPhotosLabel: UILabel!
    @IBOutlet weak var numberOfVideosLabel: UILabel!
    @IBOutlet weak var nickyNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    func updateUI() {
        if let user = PFUser.currentUser() {
            nickyNameLabel.text = user["nickyName"] as? String
            descriptionLabel.text = user["description"] as? String
            if let imageFile = user["profileImage"] as? PFFile {
                imageFile.getDataInBackgroundWithBlock({ (data, error) in
                    if let imageData = data {
                        self.profileImageView.image = UIImage(data: imageData)
                    }
                })
            }
        }
    }
    
    @IBAction func changeProfileImageButtonPressed(sender: UIButton) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .Default) { (action) -> Void in
            self.setPhotoSource("Camera")
        }
        let libraryAction = UIAlertAction(title: "Library", style: .Default) { (action) -> Void in
            self.setPhotoSource("Library")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cameraAction)
        alertController.addAction(libraryAction)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    func setPhotoSource(source: String) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        //pickerController.allowsEditing = true
        if (source == "Camera") {
            pickerController.sourceType = .Camera
            pickerController.cameraDevice = .Front
            pickerController.cameraCaptureMode = .Photo
        } else {
            pickerController.sourceType = .PhotoLibrary
        }
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if let imageData = UIImageJPEGRepresentation(image, 0.15),
                let imageFile = PFFile(data: imageData),
                let user = PFUser.currentUser() {
                user["profileImage"] = imageFile
                user.saveInBackgroundWithBlock({ (success, error) in
                    if success {
                        print("upload and save new profile image")
                    }
                })
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func settingButtonPressed(sender: UIBarButtonItem) {
        PFUser.logOutInBackgroundWithBlock { (error) in
            if error == nil {
                print("logout")
                let appDomain = NSBundle.mainBundle().bundleIdentifier
                NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
                self.profileImageView.image = UIImage(named: "cat")!
                let loginVC = self.storyboard!.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
                self.presentViewController(loginVC, animated: true, completion: nil)
            } else {
                print(error)
            }
        }
    }

}
