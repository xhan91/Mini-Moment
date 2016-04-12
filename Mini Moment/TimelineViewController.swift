//
//  TimelineViewController.swift
//  Mini Moment
//
//  Created by han xu on 2016-04-08.
//  Copyright © 2016 xhan91. All rights reserved.
//

import UIKit
import Parse

private struct ReuseableCellIdentifier {
    static let Say = "sayTimelineCell"
    static let Photo = "photoTimelineCell"
    static let Video = "videoTimelineCell"
}

class TimelineViewController: UITableViewController {

    var posts = [[Post]]()
    
    var a = [Post]()
    func sim(){
        let post1 = Post(says: "say", comment: "yeyey loves baobaobao")
//        let image = UIImage(named: "icon")
//        let data = UIImagePNGRepresentation(image!) as! PFFile
//        let post2 = Post(photos: "photo", photo: data, comment: "a photo")
        a = [post1,post1]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .None
        sim()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return posts.count ?? 0
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return posts[section].count ?? 0
        return 2
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let post = posts[indexPath.section][indexPath.row]
//        var cell = UITableViewCell()
//        switch post.type {
//        case "say":
//            cell = tableView.dequeueReusableCellWithIdentifier(ReuseableCellIdentifier.Say, forIndexPath: indexPath)
//        case "photo":
//            cell = tableView.dequeueReusableCellWithIdentifier(ReuseableCellIdentifier.Photo, forIndexPath: indexPath)
//        case "video":
//            cell = tableView.dequeueReusableCellWithIdentifier(ReuseableCellIdentifier.Video, forIndexPath: indexPath)
//        default: break
//        }
        let cell = tableView.dequeueReusableCellWithIdentifier(ReuseableCellIdentifier.Say, forIndexPath: indexPath) as! SayTableViewCell
        cell.post = a[indexPath.row]
        if indexPath.row == 0 {
            cell.isFirst = true
        } else {
            cell.isLast = true
        }
        
        return cell
    }
    
}
