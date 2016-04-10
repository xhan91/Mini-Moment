//
//  File.swift
//  Mini Moment
//
//  Created by han xu on 2016-04-08.
//  Copyright © 2016 xhan91. All rights reserved.
//

import Foundation
import UIKit
import Parse

class Post: PFObject {
    @NSManaged var type: String // says, photos, videos
    @NSManaged var photo: PFFile?
    //@NSManaged var video: PFFile?
    @NSManaged var comment: String
//    @NSManaged var createdAt: NSDate?
    @NSManaged var timestamp: NSDate
    
//    var date: String {
//        let timestampComponent = NSDateComponents()
//        let a
//        return
//    }
    
    init (type: String) {
        super.init()
        self.type = type
        timestamp = NSDate()
    }
    
    convenience init (says: String, comment: String) {
        self.init(type: "say")
        self.comment = comment
    }
    
    convenience init (photos: String, photo: PFFile, comment: String) {
        self.init(type: "photo")
        self.photo = photo
        self.comment = comment
    }
    
//    convenience init (type: String, video: , comment: String) {
//        
//    }
}