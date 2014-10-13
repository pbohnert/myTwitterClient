//
//  TweetsViewController.swift
//  TwitterClient
//
//  Created by Peter Bohnert on 10/5/14.
//  Copyright (c) 2014 Blue Lotus Labs. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var tweets = [Tweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     //   self.navigationItem.rightBarButtonItem?.enabled
     //   self.navigationController?.navigationItem.leftBarButtonItem?.enabled
     //   self.navigationController?.navigationItem.rightBarButtonItem?.enabled
     //   self.navigationController?.navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
     //   self.navigationController?.navigationBar.translucent = false
    //    self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.navigationItem.title = "Home"
                
        //signoutAction(self)
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            if (error == nil) {
                self.tweets = tweets!
                self.tableView.reloadData()
            } else {
                println("error loading tweets")
            }
        })
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func signoutAction(sender: AnyObject) {
        User.currentUser?.logout()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetCell
        cell.tweet = self.tweets[indexPath.row]

        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "tweetDetailsSegue") {
            var detailsController = segue.destinationViewController as TweetDetailViewController
            var cell = sender as TweetCell
            detailsController.tweet = cell.tweet
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

