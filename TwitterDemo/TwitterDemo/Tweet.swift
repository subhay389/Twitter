//
//  tweet.swift
//  TwitterDemo
//
//  Created by Subhay Manandhar on 2/27/17.
//  Copyright © 2017 Subhay Manandhar. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: NSString?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var userName: NSString?
    var photoUrl: NSString?
    
    var retweetCountString: String = ""
    var favCount: Int = 0
    var favCountString: String = ""
    var retweetStatus: NSDictionary?
    var reTweet: Bool?
    var favTweet: Bool?
    
    init(dictionary: NSDictionary){
        text = dictionary["text"] as? NSString
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount  = (dictionary["favorite_count"] as? Int) ?? 0
        userName = (dictionary["user"] as? NSDictionary)?["name"] as? NSString
        photoUrl = (dictionary["user"] as? NSDictionary)?["profile_image_url_https"] as? NSString
        
        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString{
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString) as NSDate?
        }
        
        
        favCount = (dictionary["favorite_count"] as? Int) ?? 0
        
        retweetStatus = dictionary["retweeted_status"] as? NSDictionary
        reTweet = (dictionary["retweeted"] as? Bool) ?? true
        favTweet = (dictionary["favorited"] as? Bool) ?? false
        
        if let retweetStatus = retweetStatus {
            retweetCount = retweetStatus["retweet_count"] as? Int ?? 0
            favCount = (retweetStatus["favourites_count"] as? Int) ?? 0
        } else {
            retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        }

    }
    
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }
    
    
}
