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
        
        TwitterClient.sharedInstance?.login(success: {
            print("Ive logged in")
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
            
        }, failure: { (error: NSError) in
            print("Error")
        })
        
    }
}
