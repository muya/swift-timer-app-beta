//
//  SavedTimesTableViewController.swift
//  swiftTimerAppBeta
//
//  Created by Muya on 17/08/2014.
//  Copyright (c) 2014 muya. All rights reserved.
//

import UIKit

class SavedTimesTableViewController: UITableViewController {
    var savedTimes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "blurPurple"))
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.savedTimes.count
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("timeCell", forIndexPath: indexPath!) as UITableViewCell
        
        // configure the cell
        cell.textLabel.text = self.savedTimes[indexPath.row]
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
}
