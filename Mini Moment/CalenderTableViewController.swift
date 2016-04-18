//
//  CalenderTableViewController.swift
//  
//
//  Created by han xu on 2016-04-17.
//
//

import UIKit
import Parse

class CalenderTableViewController: UITableViewController {

    var dates = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDateSet()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
                    self.tableView.reloadData()
                }
            })
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let calenderCell = sender as? UITableViewCell,
            let date = calenderCell.textLabel?.text,
            let destination = segue.destinationViewController.contentViewController as? TimelineViewController{
            destination.date = date
            destination.fromCalender = true
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dates.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("calenderCell", forIndexPath: indexPath)
        cell.accessoryType = .DisclosureIndicator
        cell.textLabel?.text = dates[indexPath.row]
        return cell
    }
}
