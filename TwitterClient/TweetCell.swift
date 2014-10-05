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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
