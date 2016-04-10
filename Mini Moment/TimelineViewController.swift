//
//  TimelineViewController.swift
//  Mini Moment
//
//  Created by han xu on 2016-04-08.
//  Copyright © 2016 xhan91. All rights reserved.
//

import UIKit

private struct ReuseableCellIdentifier {
    static let Say = "sayTimelineCell"
    static let Photo = "photoTimelineCell"
    static let Video = "videoTimelineCell"
}

class TimelineViewController: UITableViewController {

    var posts = [[Post]]()
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return posts.count ?? 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts[section].count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let post = posts[indexPath.section][indexPath.row]
        var cell = UITableViewCell()
        switch post.type {
        case "say":
            cell = tableView.dequeueReusableCellWithIdentifier(ReuseableCellIdentifier.Say, forIndexPath: indexPath)
        case "photo":
            cell = tableView.dequeueReusableCellWithIdentifier(ReuseableCellIdentifier.Photo, forIndexPath: indexPath)
        case "video":
            cell = tableView.dequeueReusableCellWithIdentifier(ReuseableCellIdentifier.Video, forIndexPath: indexPath)
        default: break
        }
        return cell
    }
    
}