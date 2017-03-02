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
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favTweet: UIButton!
    
    var tweet: Tweet!{
        didSet{
            
            tweetDetailLabel.text = tweet.text as? String
            tweetTitleLabel.text = tweet.userName as! String
            
            let imageURL = URL(string: tweet.imageUrl as! String)
            profileImage.setImageWith(imageURL! as URL)
            timestampLabel.text = TwitterClient.changeTimeStampFormatToString(timestamp: tweet.timestamp as! Date)
            
            retweetLabel.text = tweet.retweetCountString
            favouriteLabel.text = tweet.favCountString
            
            if (!tweet.reTweet!) {
                retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
            } else {
                retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
            }
            if (!tweet.favTweet!) {
                favTweet.setImage(UIImage(named: "favor-icon"), for: .normal)
            } else {
                favTweet.setImage(UIImage(named: "favor-icon-red"), for: .normal)
            }
            
            
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
