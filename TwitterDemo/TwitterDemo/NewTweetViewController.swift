//
//  NewTweetViewController.swift
//  TwitterDemo
//
//  Created by Subhay Manandhar on 3/7/17.
//  Copyright © 2017 Subhay Manandhar. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController {

    var tweet: Tweet!
    
    @IBAction func postButton(_ sender: Any) {
        
        TwitterClient.sharedInstance?.newTweet(inputText: tweetText.text!, success: { (response: Tweet) in
            _ = self.navigationController!.popViewController(animated: true)
        }, failure: { (error: Error) in
            
             _ = self.navigationController!.popViewController(animated: true)
            // also create a alert
//            let errorAlertController = UIAlertController(title: "Error!", message: "\(error)", preferredStyle: .alert)
//            // add ok button
//            let errorAction = UIAlertAction(title: "Ok", style: .default) { (action) in
//                //dismiss
//            }
//            errorAlertController.addAction(errorAction)
//            self.present(errorAlertController, animated: true)

        })
    }
    
    @IBOutlet weak var tweetText: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "New Tweet"
        
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

}
