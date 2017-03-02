//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by Subhay Manandhar on 2/27/17.
//  Copyright © 2017 Subhay Manandhar. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    

    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")! as URL!, consumerKey: "7TqnAWuOMnQg29w111JZeCQP1", consumerSecret: "g3vBy3lm4noXJBQPzVw3Tn1hTWYqYFxeyJ0tzVInJ84YalSmCJ")
    
    var loginSuccess: (() -> ())?
    
    var loginFailure: ((NSError) -> ())?
    
    func currentAccount() {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            print("name: \(user.name)")
            print("screenname: \(user.screenname)")
            print("profile url: \(user.profileUrl)")
            print("discription: \(user.tagline)")
            
            //print("user: \(user)")
        }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
            print("error \(error.localizedDescription)")
        })
    }
    
    func homeTimeLine(success: @escaping ([Tweet]) -> (), failure: (NSError) -> ()) {
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil,
                    success: { (task: URLSessionDataTask, response: Any?) -> Void in
                        let dictionaries = response as! [NSDictionary]
                        
                        let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
                        
                        success(tweets)
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print(error.localizedDescription)
        })
    }
    
    func login(success: @escaping ()-> (), failure: @escaping (NSError) -> ()){
        
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance?.deauthorize()
        
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string:"twitterdemo://oauth") as URL!, scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void in
            
            let myToken = requestToken!.token as String!
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(myToken!)")!
            UIApplication.shared.openURL(url as URL)
            
        }, failure: { (error:Error?)-> Void in
            print ("Error getting token: \(error!.localizedDescription)")
            self.loginFailure?(error as! NSError)
        })
    }
    
    func handleOpenUrl(url: NSURL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) -> Void in
            print("I got a access token")
            
            self.currentAccount(success: { (user: User) in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: { (error: NSError) in
                self.loginFailure?(error as! NSError)
            })
            

            
        }, failure: { (error: Error?) -> Void in
            print("error \(error?.localizedDescription)")
            self.loginFailure?(error as! NSError)
        })
    }
    
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
        
    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (NSError) -> ()){
        get("1.1/account/verify_credentials.json", parameters: nil,progress: nil, success: {(task: URLSessionDataTask, response: Any?) -> Void in
            // print("account: \(response)")
            let userDictionary = response as! NSDictionary
            
            let user = User(dictionary: userDictionary)
            success(user)
            
        }, failure: {( task: URLSessionDataTask?, error: Error) -> Void in
            failure(error as NSError)
        })
    }

}
