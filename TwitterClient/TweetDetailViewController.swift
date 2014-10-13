//
//  TweetDetailViewController.swift
//  TwitterClient
//
//  Created by Peter Bohnert on 10/13/14.
//  Copyright (c) 2014 Blue Lotus Labs. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetImage: UIImageView!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
      var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tweetImage.setImageWithURL(tweet?.user.profileImageURL)
        self.tweetImage.layer.cornerRadius = 10.0
        self.tweetImage.clipsToBounds = true
        self.nameLabel.text = tweet?.user.name
        self.screenNameLabel.text = "@\(tweet!.user.screenName)"
        self.tweetText.text = tweet?.text
        self.timestampLabel.text = tweet?.createdAtString

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
