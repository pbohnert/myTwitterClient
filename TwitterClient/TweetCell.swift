//
//  TweetCell.swift
//  TwitterClient
//
//  Created by Peter Bohnert on 10/5/14.
//  Copyright (c) 2014 Blue Lotus Labs. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var useridLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    var tweet: Tweet? {
        didSet {
            self.personImage.setImageWithURL(self.tweet!.user?.profileImageURL)
            self.nameLabel.text = self.tweet!.user.name
            self.useridLabel.text = "@\(self.tweet!.user.screenName)"
            self.tweetLabel.text = self.tweet!.text
            self.timestampLabel.text = self.tweet!.createdAt.shortTimeAgoSinceNow()
            
            
            self.personImage.layer.cornerRadius = 10.0
            self.personImage.clipsToBounds = true
            
            self.layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
