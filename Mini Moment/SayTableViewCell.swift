//
//  sayTableViewCell.swift
//  Mini Moment
//
//  Created by han xu on 2016-04-11.
//  Copyright © 2016 xhan91. All rights reserved.
//

import UIKit

class SayTableViewCell: UITableViewCell {

    var isFirst: Bool = false
    var isLast: Bool = false
    
    @IBOutlet weak var sayTextView: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
