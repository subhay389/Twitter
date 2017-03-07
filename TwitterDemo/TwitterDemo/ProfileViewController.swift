//
//  ProfileViewController.swift
//  TwitterDemo
//
//  Created by Subhay Manandhar on 3/6/17.
//  Copyright © 2017 Subhay Manandhar. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var tweet: Tweet!
    var tweets: [Tweet]! = []
    
    var user: User!

    @IBOutlet weak var profileImagelabel: UIImageView!
    @IBOutlet weak var backgroundImageLabel: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var totalTweetsLabel: UILabel!
    @IBOutlet weak var totalFollowersLabel: UILabel!
    @IBOutlet weak var totalFollowingLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationItem.title = "ME"
        
        profileImagelabel.setImageWith(user.profileUrl! as URL)
        displayNameLabel.text = ("@\(user.screenname!)")
        nameLabel.text = user.name! as String
        
        let followers = (user.dictionary?["followers_count"] as? Int) ?? 0
        totalFollowersLabel.text = "\(followers)"
        
        
        let following = (user.dictionary?["friends_count"] as? Int) ?? 0
        totalFollowingLabel.text =  "\(following)"
        
        let tweets = (user.dictionary?["statuses_count"] as? Int) ?? 0
        totalTweetsLabel.text = "\(tweets)"
        
        let bg_img_str = user.dictionary?["profile_background_image_url_https"] as! String
        let background_image_url = URL(string: bg_img_str)
        
        backgroundImageLabel.setImageWith(background_image_url!)
        
        
//        profileImagelabel.setImageWith(User.)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
