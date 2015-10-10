//
//  TwitterMainViewController.swift
//  Codepath Twitter
//
//  Created by admin on 10/9/15.
//  Copyright © 2015 mattmo. All rights reserved.
//

import UIKit

class TwitterMainViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var twitterMenuContainerView: UIView!
    @IBOutlet weak var tweetsContainerView: UIView!
    
    var twitterMenuVC: TwitterMenuViewController!
    var tweetsVC: TweetsViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.scrollView.setContentOffset(CGPointMake(self.twitterMenuVC.view.bounds.width, 0), animated: false);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "homeViewInMain" {
            self.tweetsVC = segue.destinationViewController as? TweetsViewController
        }
        if segue.identifier == "menuViewInMain" {
            self.twitterMenuVC = segue.destinationViewController as? TwitterMenuViewController
        }
    }

}
