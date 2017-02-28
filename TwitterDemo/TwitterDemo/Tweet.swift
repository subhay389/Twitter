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
    var retweetCount: String?
    var favoritesCount: String?
    var userName: NSString?
    var photoUrl: NSString?
    
    init(dictionary: NSDictionary){
        text = dictionary["text"] as? NSString
        retweetCount = (dictionary["retweet_count"] as? String) ?? ""
        favoritesCount = (dictionary["favourites_count"] as? String) ?? ""
        
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString{
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString) as NSDate?
        }
        userName = (dictionary["user"] as? NSDictionary)?["name"] as? NSString
        
        photoUrl = (dictionary["user"] as? NSDictionary)?["profile_image_url_https"] as? NSString

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
