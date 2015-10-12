//
//  TwitterMainViewController.swift
//  Codepath Twitter
//
//  Created by admin on 10/9/15.
//  Copyright © 2015 mattmo. All rights reserved.
//

import UIKit

class TwitterMainViewController: UIViewController, UIScrollViewDelegate, MenuButtonDelegate, TimelineChangeDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var twitterMenuContainerView: UIView!
    @IBOutlet weak var tweetsContainerView: UIView!
    
    var twitterMenuVC: TwitterMenuViewController!
    var tweetsVC: TweetsViewController!
    
    var viewLoaded: Bool = false;
    var menuIsScrolling: Bool = false;
    var lastScrollOffsetX: CGFloat!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.delegate = self;
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        self.scrollView.setContentOffset(CGPointMake(self.twitterMenuVC.view.bounds.width, 0), animated: false);
        self.lastScrollOffsetX = self.scrollView.contentOffset.x
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - MenuButtonDelegate
    func openMenu() {
        self.menuIsScrolling = true
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.scrollView.setContentOffset(CGPointMake(0, 0), animated: false)
            self.menuIsScrolling = false
            self.tweetsContainerView.userInteractionEnabled = false;
        })
    }
    
    func closeMenu() {
        self.menuIsScrolling = true
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.scrollView.setContentOffset(CGPointMake(self.twitterMenuVC.view.bounds.width, 0), animated: false)
            self.menuIsScrolling = false
            self.tweetsContainerView.userInteractionEnabled = true;
        })
    }
    
    // MARK: - TimelineChange Delegate
    func changeTimeline(type: TimelineType) {
        self.tweetsVC.loadTweets(type);
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "homeViewInMain" {
            let navVC = segue.destinationViewController as? UINavigationController
            self.tweetsVC = navVC?.topViewController as? TweetsViewController
            self.tweetsVC.delegate = self;
        }
        if segue.identifier == "menuViewInMain" {
            self.twitterMenuVC = segue.destinationViewController as? TwitterMenuViewController
            self.twitterMenuVC.timelineChangeDelegate = self;
            self.twitterMenuVC.menuButtonDelegate = self;
        }
    }

    // MARK: - Scroll View
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.lastScrollOffsetX = self.scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if !self.menuIsScrolling {
            self.menuIsScrolling = true
            // Swipe Left
            if self.scrollView.contentOffset.x > self.lastScrollOffsetX {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.scrollView.setContentOffset(CGPointMake(self.twitterMenuVC.view.bounds.width, 0), animated: false)
                    self.menuIsScrolling = false
                    self.tweetsContainerView.userInteractionEnabled = true;
                })
            } else { // Swipe Right
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.scrollView.setContentOffset(CGPointMake(0, 0), animated: false)
                    self.menuIsScrolling = false
                    self.tweetsContainerView.userInteractionEnabled = false;
                })
            }
        }
    }
}
