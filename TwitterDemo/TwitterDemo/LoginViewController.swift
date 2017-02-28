//
//  LoginViewController.swift
//  TwitterDemo
//
//  Created by Subhay Manandhar on 2/27/17.
//  Copyright © 2017 Subhay Manandhar. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onLoginButton(_ sender: Any) {
        let twitterClient = BDBOAuth1SessionManager(baseURL: NSURL(string: "https://api.twitter.com")! as URL!, consumerKey: "7TqnAWuOMnQg29w111JZeCQP1", consumerSecret: "g3vBy3lm4noXJBQPzVw3Tn1hTWYqYFxeyJ0tzVInJ84YalSmCJ")
        
        twitterClient?.deauthorize()
        
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string:"twitterdemo://oauth") as URL!, scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void in
            print ("Got token")
            
            let myToken = requestToken!.token as String!
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(myToken!)")!
            UIApplication.shared.openURL(url as URL)
            
        }, failure: { (error:Error?)-> Void in
            print ("Error getting token: \(error!.localizedDescription)")
        })
        
    }
}
