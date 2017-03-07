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

    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
        
    }
    var tweets: [Tweet]!
    
    @IBAction func newTweetButton(_ sender: Any) {
        self.performSegue(withIdentifier: "newTweetSegue", sender: sender)
    }
    
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
    
    @IBAction func imageOnTap(_ sender: Any) {
        self.performSegue(withIdentifier: "profileViewSegue", sender: sender)
        
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
        cell.favouriteLabel.text = String(eachTweet.favoritesCount)
        cell.retweetLabel.text = String(eachTweet.retweetCount)
        cell.dateLabel.text = String(describing: eachTweet.timestamp!)
        
        cell.tweet = eachTweet

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailViewSegue"{
            let cell = sender as! UITableViewCell
            
            let indexPath = tableView.indexPath(for: cell)
            let tweet = tweets![(indexPath!.row)]
            let detailViewController = segue.destination as! TweetDetailsViewController
            
            detailViewController.tweet = tweet
        }
        
        if segue.identifier == "profileViewSegue" {
            var indexPath: NSIndexPath!
            
            if let button = sender as? UIButton {
                if let superview = button.superview {
                    if let cell = superview.superview as? TweetCell {
                        indexPath = tableView.indexPath(for: cell) as NSIndexPath!
                    }
                }
            }
            let tweet = self.tweets[indexPath.row]
            
            let profileViewControl = segue.destination as! ProfileViewController
            
            profileViewControl.user = User(dictionary: tweet.userDictionary!)
            
        }
//        if segue.identifier == "newTweetSegue" {
//            let controller = segue.destination as! NewTweetViewController
//            
//            print ("reply Segue")
//        }
    }
    
}
