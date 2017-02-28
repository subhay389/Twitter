//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Subhay Manandhar on 2/27/17.
//  Copyright © 2017 Subhay Manandhar. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    var tweets: [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            
            for tweet in tweets{
                print(tweet.text!)
            }
            self.tableView.reloadData()
            
        }, failure: { (error: NSError) in
            print(error.localizedDescription)
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        } else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let eachTweet = tweets[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweetDetailLabel.text = eachTweet.text as? String
        cell.tweetTitleLabel.text = eachTweet.userName as! String
        let imageURL = URL(string: eachTweet.photoUrl as! String)
        cell.photoLabel?.setImageWith(imageURL!)
        cell.favouriteLabel.text = eachTweet.favoritesCount!
        cell.retweetLabel.text = eachTweet.retweetCount!

        return cell
    }
}
