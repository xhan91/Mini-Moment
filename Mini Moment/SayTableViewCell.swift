//
//  sayTableViewCell.swift
//  Mini Moment
//
//  Created by han xu on 2016-04-11.
//  Copyright © 2016 xhan91. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class SayTableViewCell: UITableViewCell {
    
    var isFirst: Bool = false {
        didSet{
            upBar.hidden = isFirst
            dateLabel.hidden = !isFirst
        }
    }
    var isLast: Bool = false {
        didSet{
            downBar.hidden = isLast
        }
    }
    
    @IBOutlet weak var sayTextView: UITextView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var playerView: UIView!
    var playerViewController: AVPlayerViewController!
    
    @IBOutlet weak var upBar: UIView!
    @IBOutlet weak var downBar: UIView!
    @IBOutlet weak var dateLabel: UILabel!
        
    var post: Post? {
        didSet{
            if let post = post {
                dateLabel.text = " " + post.date + "  "
                dateLabel.textColor = UIColor.whiteColor()
                switch post.type {
                case "say":
                    playerView.hidden = true
                    photoImageView.hidden = true
                    sayTextView.hidden = false
                    
                    sayTextView.text = post.comment
                    commentTextView.hidden = true
                case "photo":
                    playerView.hidden = true
                    photoImageView.hidden = false
                    sayTextView.hidden = true
                    
                    commentTextView.hidden = false
                    commentTextView.text = post.comment
                    commentTextView.textColor = UIColor.whiteColor()
                    photoImageView.hidden = false
                    let photoFile = post.photo
                    photoFile.getDataInBackgroundWithBlock({ (data, error) in
                        if let data = data {
                            let photo = UIImage(data: data)
                            self.photoImageView.image = photo
                        }
                    })
                case "video":
                    playerView.hidden = false
                    photoImageView.hidden = true
                    sayTextView.hidden = true
                    
                    let videoFile = post.video
                    videoFile.getDataInBackgroundWithBlock({ (data, error) in
                        if let data = data {
                            let size = Float(data.length)/1024.0/1024.0
                            self.commentTextView.hidden = false
                            self.commentTextView.text = String(format: "%.2f MB", size)
                            self.commentTextView.textColor = UIColor.whiteColor()
                            let tmp = NSTemporaryDirectory()
                            let videoPath = "\(tmp)/\(post.objectId).mp4"
                            let videoURL = NSURL(fileURLWithPath: videoPath)
//                            try! data.writeToURL(videoURL, options: [.AtomicWrite])
                            data.writeToURL(videoURL, atomically: true)
                            
                            let player = AVPlayer(URL: videoURL)
                            self.playerViewController.player = player
                        }
                    })
                default:
                    break;
                }
            }
        }
    }
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var commentTextView: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layoutIfNeeded()
        
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 10
        dateLabel.layer.cornerRadius = 10
        dateLabel.clipsToBounds = true
        
        /* set up 3 views for 3 types of posts */
//        sayTextView = UITextView(frame: CGRectMake(0, 0, containerView.bounds.width, containerView.bounds.height))
        sayTextView.editable = false
//        containerView.addSubview(sayTextView)
        
//        photoImageView = UIImageView(frame: CGRectMake(0, 0, self.containerView.bounds.width, self.containerView.bounds.width))
//        photoImageView.contentMode = .ScaleAspectFill
        photoImageView.contentMode = .ScaleAspectFill
        photoImageView.layer.cornerRadius = 5
//        containerView.insertSubview(photoImageView, atIndex: 0)

        playerViewController = AVPlayerViewController()
        playerViewController.view.frame = playerView.bounds
//        containerView.insertSubview(playerViewController.view, atIndex: 0)
        playerView.addSubview(playerViewController.view)
        
        sayTextView.hidden = true
        photoImageView.hidden = true
        playerView.hidden = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
