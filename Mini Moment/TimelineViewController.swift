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
    var dates = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .None
        updateData()
    }
    
    @IBAction func refreshControlPulled(sender: UIRefreshControl) {
        updateData()
    }
    
    func updateData() {
        getDateSet()
        if let query = Post.query(),
            let user = PFUser.currentUser(){
            query.orderByDescending("timestamp")
            query.whereKey("user", equalTo: user)
            query.findObjectsInBackgroundWithBlock({ (posts, error) in
                if let posts = posts as? [Post] {
                    self.posts = []
                    for date in self.dates {
                        var postsOfTheDay = [Post]()
                        for post in posts {
                            if post.date == date {
                                postsOfTheDay.append(post)
                            }
                        }
                        self.posts.append(postsOfTheDay)
                    }
                    self.refreshControl?.endRefreshing()
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    func getDateSet() {
        if let query = Post.query(),
            let user = PFUser.currentUser() {
            query.orderByDescending("timestamp")
            query.whereKey("user", equalTo: user)
            query.findObjectsInBackgroundWithBlock({ (posts, error) in
                if let posts = posts as? [Post] {
                    self.dates = []
                    for post in posts {
                        if !self.dates.contains(post.date) {
                            self.dates.append(post.date)
                        }
                    }
                }
            })
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return posts.count ?? 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts[section].count ?? 0
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
        let post = posts[indexPath.section][indexPath.row]
        cell.post = post
        if indexPath.row == 0 {
            cell.isFirst = true
        } else {
            cell.isFirst = false
        }
        let lastPost = posts[indexPath.section].last
        if post == lastPost {
            cell.isLast = true
        } else {
            cell.isLast = false
        }
        return cell
    }
    
}
