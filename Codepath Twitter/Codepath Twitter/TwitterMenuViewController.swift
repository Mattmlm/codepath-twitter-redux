//
//  TwitterMenuViewController.swift
//  Codepath Twitter
//
//  Created by admin on 10/9/15.
//  Copyright © 2015 mattmo. All rights reserved.
//

import UIKit

protocol TimelineChangeDelegate: class {
    func changeTimeline(type: TimelineType);
}

class TwitterMenuViewController: UIViewController {

    weak var menuButtonDelegate: MenuButtonDelegate?
    weak var timelineChangeDelegate: TimelineChangeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func homeButtonPressed(sender: Any) {
//        self.menuButtonDelegate?.closeMenu()
//        self.timelineChangeDelegate?.changeTimeline(TimelineType.Home);
    }
//
    @IBAction func profileButtonPressed(sender: Any) {
//        self.menuButtonDelegate?.closeMenu()
//        let profileVC = TwitterProfileViewController()
//        profileVC.user = User.currentUser
//        let navVC = UINavigationController(rootViewController: profileVC)
//        self.presentViewController(navVC, animated: true, completion: nil)
    }
//
    @IBAction func mentionsButtonPressed(sender: Any) {
//        self.menuButtonDelegate?.closeMenu()
//        self.timelineChangeDelegate?.changeTimeline(TimelineType.Mentions)
    }
    @IBAction func signOutButtonPressed(sender: Any) {
//        User.currentUser?.logout()
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
