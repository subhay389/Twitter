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
            
//            tweetDetailLabel.text = tweet.text as? String
//            tweetTitleLabel.text = tweet.userName as! String
//            
//            retweetLabel.text = tweet.retweetCountString
//            favouriteLabel.text = tweet.favCountString
            
            if (!tweet.reTweeted!) {
                retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
            } else {
                retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
            }
            if (!tweet.favTweeted!) {
                favTweet.setImage(UIImage(named: "favor-icon"), for: .normal)
            } else {
                favTweet.setImage(UIImage(named: "favor-icon-red"), for: .normal)
            }
            
            
            
        }
    }
    @IBAction func onRetweet(_ sender: Any) {
        tweet.reTweeted! = !tweet.reTweeted!
        if (self.tweet.reTweeted!) {
            
            self.tweet.retweetCount += 1
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
        } else {
            self.tweet.retweetCount -= 1
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
        }
        
        self.tweet.retweetCountString = "\(self.tweet.retweetCount)"
        retweetLabel.text = self.tweet.retweetCountString

    }
    
    @IBAction func onFavPressed(_ sender: Any) {
        self.tweet.favTweeted = !self.tweet.favTweeted!
        
        if (self.tweet.favTweeted!) {
            self.tweet.favCount += 1
            favTweet.setImage(UIImage(named: "favor-icon-red"), for: .normal)
        } else {
            self.tweet.favCount -= 1
            favTweet.setImage(UIImage(named: "favor-icon"), for: .normal)
        }
        
        self.tweet.favCountString = "\(self.tweet.favCount)"
        favouriteLabel.text = self.tweet.favCountString

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
