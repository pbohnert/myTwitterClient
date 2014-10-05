//
//  ViewController.swift
//  TwitterClient
//
//  Created by Peter Bohnert on 10/5/14.
//  Copyright (c) 2014 Blue Lotus Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var tweets:  [[String:String]]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweets = [["name":"Peter", "userid":"ptbohnert", "tweet": "I'm really enjoying this class and wondering if I'll catch up on homework EVER!"],
                ["name" : "Isabel", "userid" : "iuser", "tweet": "Gee, my commute is long.  I wonder if I should rent a car next week?"],
                ["name" : "Jonathan", "userid" : "juser", "tweet": "Really trying to get enough done at work that I can take tomorrow off to work on homework"]]
        
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetCell
        
        var tweet = tweets[indexPath.row]
        
        cell.nameLabel.text = tweet["name"]
        cell.useridLabel.text = tweet["userid"]
        cell.tweetLabel.text = tweet["tweet"]
        cell.timestampLabel.text = "2h"
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

