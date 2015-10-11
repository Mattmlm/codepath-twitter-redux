//
//  TwitterProfileViewController.swift
//  Codepath Twitter
//
//  Created by admin on 10/11/15.
//  Copyright © 2015 mattmo. All rights reserved.
//

import UIKit

class TwitterProfileViewController: UIViewController {

    weak var user: User!
    
    @IBOutlet weak var profileBackgroundImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!

    @IBOutlet weak var tweetsCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = user?.name!
        let closeButton = UIBarButtonItem(title: "Close", style: .Plain, target: self, action: "closeProfile")
        self.navigationItem.leftBarButtonItem = closeButton;
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor(rgba: "#55ACEE");
        self.navigationController?.navigationBar.translucent = false;
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor();
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black;
        
        self.tweetsCountLabel.text = "\(user.tweetsCount!)"
        self.followingCountLabel.text = "\(user.followingCount!)"
        self.followersCountLabel.text = "\(user.followersCount!)"
        
        self.profileBackgroundImageView.setImageWithURL(NSURL(string: user.profileBackgroundImageUrl!)!)
        self.profileImageView.setImageWithURL(NSURL(string: user.profileImageUrl!)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func closeProfile() {
        dismissViewControllerAnimated(true, completion: nil);
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
