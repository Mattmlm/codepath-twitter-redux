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

        // Do any additional setup after loading the view.
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
