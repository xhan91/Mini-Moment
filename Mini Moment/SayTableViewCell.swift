//
//  sayTableViewCell.swift
//  Mini Moment
//
//  Created by han xu on 2016-04-11.
//  Copyright © 2016 xhan91. All rights reserved.
//

import UIKit
import MediaPlayer

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
    
    @IBOutlet weak var upBar: UIView!
    @IBOutlet weak var downBar: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var post: Post? {
        didSet{
            switch post!.type {
            case "say":
                let sayTextView = UITextView(frame: CGRectMake(0, 0, 240, 140))
                sayTextView.editable = false
                sayTextView.text = post!.comment
                self.containerView.addSubview(sayTextView)
            case "photo":
                let photoImageView = UIImageView(frame: CGRectMake(0, 0, 240, 140))
                photoImageView.contentMode = .ScaleAspectFill
//            case "video":
//                let moviePlayer = MPMoviePlayerController(contentURL: <#T##NSURL!#>)
//                
            default:
                break;
            }
        }
    }
    
    @IBOutlet weak var containerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
