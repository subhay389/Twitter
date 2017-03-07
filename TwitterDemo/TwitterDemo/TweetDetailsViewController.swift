//
//  TweetDetailsViewController.swift
//  TwitterDemo
//
//  Created by Subhay Manandhar on 3/6/17.
//  Copyright © 2017 Subhay Manandhar. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {
    
    
    var retweeted: Bool?
    var favorite: Bool?
    
    var tweet: Tweet!

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var retweetLabel: UILabel!
    
    @IBOutlet weak var favoriteLabel: UILabel!
    
    @IBAction func replyButton(_ sender: Any) {
    }
    @IBOutlet weak var retweetButtonLabel: UIButton!
    @IBOutlet weak var replyButtonLabel: UIButton!
    
    @IBOutlet weak var favTweetButtonLabel: UIButton!
    
    @IBAction func favTweetButton(_ sender: Any) {
        
        self.favorite = !self.favorite!
        if let tweetID = self.tweet {
            TwitterClient.sharedInstance?.favoritePost(favoriting: self.favorite!, tweetID: tweet.id_str!)
        }
        
        if self.favorite! {
            favTweetButtonLabel.setImage(UIImage(named: "favor-icon-1"), for: .normal)
            tweet.favCount += 1
            favoriteLabel.text = "\(tweet.favCount)"
        }
        else {
            favTweetButtonLabel.setImage(UIImage(named: "favor-icon"), for: .normal)
            tweet.favCount -= 1
            favoriteLabel.text = "\(tweet.favCount)"
        }
        
    }
    
    
    
    @IBAction func retweetButton(_ sender: Any) {
        self.retweeted = !self.retweeted!
        if let tweetID = self.tweet {
            TwitterClient.sharedInstance?.reTweet(retweeting: self.retweeted!, tweetID: tweet.id_str!)
            //print(tweetID)
            //print(self.retweeted!)
        }
        
        if self.retweeted! {

            retweetButtonLabel.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
            tweet.retweetCount += 1
            retweetLabel.text = "\(tweet.retweetCount)"
        }
        else {
            retweetButtonLabel.setImage(UIImage(named: "retweet-icon"), for: .normal)
            tweet.retweetCount -= 1
            retweetLabel.text = "\(tweet.retweetCount)"
        }

    }

        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retweeted = tweet.reTweeted
        favorite = tweet.favTweeted
        
        let baseURL = tweet.photoUrl
        let imageURL = URL(string: baseURL as! String)
        profileImageView.setImageWith(imageURL! as URL!)

        var tempString: String
        tempString = tweet.screenName as String!
        tempString = "@" + tempString
        usernameLabel.text = tempString
        
        nameLabel.text = tweet.userName as! String
        
        tweetLabel.text = tweet.text as String?
        
        retweetLabel.text = String(tweet.retweetCount)
        
        favoriteLabel.text = String(tweet.favoritesCount)
        
        dateLabel.text = tweet.timestamp as? String

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
