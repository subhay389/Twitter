//
//  TweetCell.swift
//  TwitterDemo
//
//  Created by Subhay Manandhar on 2/28/17.
//  Copyright © 2017 Subhay Manandhar. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    @IBOutlet weak var tweetTitleLabel: UILabel!

    @IBOutlet weak var tweetDetailLabel: UILabel!
    
    @IBOutlet weak var photoLabel: UIImageView!
    
    @IBOutlet weak var retweetLabel: UILabel!
    
    @IBOutlet weak var favouriteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
