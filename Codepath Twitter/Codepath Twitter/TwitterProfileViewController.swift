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
        let closeButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeProfile))
        self.navigationItem.leftBarButtonItem = closeButton;
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor(rgba: "#55ACEE");
        self.navigationController?.navigationBar.isTranslucent = false;
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black;
        
        self.tweetsCountLabel.text = "\(user.tweetsCount!)"
        self.followingCountLabel.text = "\(user.followingCount!)"
        self.followersCountLabel.text = "\(user.followersCount!)"
        
        self.profileBackgroundImageView.setImageWith(URL(string: user.profileBackgroundImageUrl!)!)
        self.profileImageView.setImageWith(URL(string: user.profileImageUrl!)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func closeProfile() {
        dismiss(animated: true, completion: nil);
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
