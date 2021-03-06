//
//  LoginViewController.swift
//  Codepath Twitter
//
//  Created by admin on 10/1/15.
//  Copyright © 2015 mattmo. All rights reserved.
//

import UIKit
import AFNetworking
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLoginButtonPressed(sender: Any) {
        sharedTwitterClient.loginWithCompletion {
            (user, error) -> () in
            if user != nil {
                // perform segue
                self.performSegue(withIdentifier: "LoginSegue", sender: self)
            } else {
                // handle login error
            }
        }
    }
}

