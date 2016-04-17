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

class Post: PFObject, PFSubclassing {
    
    static func parseClassName() -> String {
        return "Post"
    }
    
    @NSManaged var user: PFUser
    @NSManaged var type: String // say, photo, video
    @NSManaged var photo: PFFile
    @NSManaged var video: PFFile
    @NSManaged var comment: String
    @NSManaged var timestamp: NSDate
    @NSManaged var date: String
    @NSManaged var localeTime: String
    
    convenience init(comment: String) {
        self.init()
        self.type = PostType.Say
        self.comment = comment
        timestamp = NSDate()
        date = transformTimestampToDate(timestamp)
        localeTime = transformTimestampToLocaleTime(timestamp)
        user = PFUser.currentUser()!
    }
    
    convenience init(photo: PFFile, comment: String) {
        self.init()
        self.type = PostType.Photo
        self.photo = photo
        self.comment = comment
        timestamp = NSDate()
        date = transformTimestampToDate(timestamp)
        localeTime = transformTimestampToLocaleTime(timestamp)
        user = PFUser.currentUser()!
    }
    
    convenience init(video: PFFile, comment: String) {
        self.init()
        self.type = PostType.Video
        self.video = video
        self.comment = comment
        timestamp = NSDate()
        date = transformTimestampToDate(timestamp)
        localeTime = transformTimestampToLocaleTime(timestamp)
        user = PFUser.currentUser()!
    }
    
    func transformTimestampToDate(timestamp: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        let date = formatter.stringFromDate(timestamp)
        return date
    }
    
    func transformTimestampToLocaleTime(timestamp: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        let localeTime = formatter.stringFromDate(timestamp)
        return localeTime
    }
}