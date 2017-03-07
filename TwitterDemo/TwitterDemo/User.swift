//
//  user.swift
//  TwitterDemo
//
//  Created by Subhay Manandhar on 2/27/17.
//  Copyright © 2017 Subhay Manandhar. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: NSString?
    var screenname: NSString?
    var profileUrl: NSURL?
    var tagline: NSString?
    
    var dict = ()
    
    var dictionary: NSDictionary?
    
    static let userDidLogoutNotification = "UserDidLogout"
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"] as! NSString?
        screenname = dictionary["screen_name"] as? NSString
        
        let profileUrlString = dictionary["profile_image_url_https"] as? NSString
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString as String)
        }
        
        tagline = dictionary["discription"] as? NSString
    }
    
    static var _currentUser: User?

    class var currentUser: User? {
        get{
            if _currentUser == nil{
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? NSData //if there is user, return it
                if let userData = userData{ //turn back to user and store to currentUser
                    do{
                        let dictionary =  try JSONSerialization.jsonObject(with: userData as Data, options: []) as! NSDictionary
                        _currentUser = User(dictionary: dictionary)
                        
                    }
                    catch let error as NSError{
                        print("Caught error" , error.localizedDescription)
                    }
                    
                }
            }
            return _currentUser
            
            
        }
        
        set(user){
            _currentUser = user
            let defaults = UserDefaults.standard
            if let user = user{ //if user does exits
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set (data, forKey: "currentUserData")
            }
            else{
                defaults.set (nil, forKey: "currentUserData")
            }
            
            defaults.synchronize() //saves it to disk
            
        }
    }
    
    
    
}
