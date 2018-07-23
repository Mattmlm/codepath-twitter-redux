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
    
    /*
     * These two variables are explicitly set in prepare(for segue:)
     */
    var twitterMenuVC: TwitterMenuViewController!
    var tweetsVC: TweetsViewController!
    
    var menuIsScrolling: Bool = false;
    var lastScrollOffsetX: CGFloat = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.delegate = self;
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        self.scrollView.setContentOffset(CGPoint(x: self.twitterMenuVC.view.bounds.width, y: 0), animated: false);
        self.lastScrollOffsetX = self.scrollView.contentOffset.x
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - MenuButtonDelegate
    func toggleMenu(view: UIView, sender: Any) {
        self.scrollView.contentOffset.x != 0 ? openMenu(view: view, sender: sender) : closeMenu(view: view, sender: sender)
    }
    func openMenu(view: UIView, sender: Any) {
        self.menuIsScrolling = true
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            self.menuIsScrolling = false
            view.isUserInteractionEnabled = false;
        })
    }
    
    func closeMenu(view: UIView, sender: Any) {
        self.menuIsScrolling = true
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.scrollView.setContentOffset(CGPoint(x: self.twitterMenuVC.view.bounds.width, y: 0), animated: false)
            self.menuIsScrolling = false
            self.tweetsContainerView.isUserInteractionEnabled = true;
            view.isUserInteractionEnabled = true;
        })
    }
    
    // MARK: - TimelineChange Delegate
    func changeTimeline(type: TimelineType) {
        self.tweetsVC.loadTweets(type: type);
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "homeViewInMain" {
            let navVC = segue.destination as? UINavigationController
            self.tweetsVC = navVC?.topViewController as? TweetsViewController
            self.tweetsVC.delegate = self;
        }
        if segue.identifier == "menuViewInMain" {
            self.twitterMenuVC = segue.destination as? TwitterMenuViewController
            self.twitterMenuVC.timelineChangeDelegate = self;
            self.twitterMenuVC.menuButtonDelegate = self;
        }
    }

    // MARK: - Scroll View
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastScrollOffsetX = self.scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !self.menuIsScrolling {
            self.menuIsScrolling = true
            // Swipe Left
            if scrollView.contentOffset.x > self.lastScrollOffsetX {
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    scrollView.setContentOffset(CGPoint(x: self.twitterMenuVC.view.bounds.width, y: 0), animated: false);
                    self.menuIsScrolling = false
                    self.tweetsContainerView.isUserInteractionEnabled = true;
                })
            } else { // Swipe Right
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
                    self.menuIsScrolling = false
                    self.tweetsContainerView.isUserInteractionEnabled = false;
                })
            }
        }
    }
}
