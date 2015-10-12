//
//  TwitterMenuViewController.swift
//  Codepath Twitter
//
//  Created by admin on 10/9/15.
//  Copyright © 2015 mattmo. All rights reserved.
//

import UIKit

class TwitterMenuViewController: UIViewController {

    weak var delegate: MenuButtonDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func homeButtonPressed(sender: AnyObject) {
        self.delegate?.closeMenu()
    }
    
    @IBAction func profileButtonPressed(sender: AnyObject) {
        self.delegate?.closeMenu()
        let profileVC = TwitterProfileViewController()
        profileVC.user = User.currentUser
        let navVC = UINavigationController(rootViewController: profileVC)
        self.presentViewController(navVC, animated: true, completion: nil)
    }
    
    @IBAction func mentionsButtonPressed(sender: AnyObject) {
        self.delegate?.closeMenu()
    }
    @IBAction func signOutButtonPressed(sender: AnyObject) {
        User.currentUser?.logout()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
