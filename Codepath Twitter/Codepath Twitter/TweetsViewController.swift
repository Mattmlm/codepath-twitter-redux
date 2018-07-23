//
//  TweetsViewController.swift
//  Codepath Twitter
//
//  Created by admin on 10/3/15.
//  Copyright © 2015 mattmo. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol MenuButtonDelegate: class {
    func openMenu(view: UIView, sender: Any)
    func closeMenu(view: UIView, sender: Any)
    func toggleMenu(view: UIView, sender: Any)
}

enum TimelineType: Int {
    case Home = 0, Mentions
}

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TweetCellDelegate {

    var tweets: [Tweet]? = []
    var refreshControl = UIRefreshControl()
    var formatter = DateComponentsFormatter()
    var timelineType: TimelineType? = .Home
    var refreshTable: (([Tweet]?, Error?) -> ())?
    weak var delegate: MenuButtonDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshTable = { (tweets: [Tweet]?, error: Error?) -> () in
            MBProgressHUD.hide(for: self.view, animated: true)
            if (tweets != nil) {
                self.tweets = tweets
                self.tableView.reloadData();
            } else {
                print("Error getting timeline tweets:\(String(describing:error))")
            }
        }
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor(rgba: "#55ACEE");
        self.navigationController?.navigationBar.isTranslucent = false;
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black;
        
        let btn = UIBarButtonItem(image: UIImage(named: "hamburger"), style: .plain, target: self, action: #selector(menuButtonPressed(sender:)));
        self.navigationItem.leftBarButtonItem = btn
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        let tweetCellNib = UINib(nibName: "TweetTableViewCell", bundle: nil)
        self.tableView.register(tweetCellNib, forCellReuseIdentifier: "TweetCell")
        
        self.tableView.estimatedRowHeight = 120;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        // Set up refresh control
        self.refreshControl.addTarget(self, action: #selector(TweetsViewController.onRefresh), for: .valueChanged)
        self.tableView.insertSubview(self.refreshControl, at: 0)
        
        self.loadTweets(type: TimelineType.Home);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadTweets(type: TimelineType) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        if (type == .Home) {
            let refreshTable = self.refreshTable
            sharedTwitterClient.homeTimelineWithCompletion(params: nil, completion: refreshTable);
            self.timelineType = .Home;
        } else if (type == .Mentions) {
//            sharedTwitterClient.mentionsTimelineWithCompletion(params: nil, completion: self.refreshTable);
            self.timelineType = .Mentions;
        }
    }
    
    @objc func onRefresh() {
        if self.timelineType == .Home {
            sharedTwitterClient.homeTimelineWithCompletion(params: nil) { (tweets, error) -> () in
                self.refreshControl.endRefreshing()
                if let refreshTable = self.refreshTable {
                    refreshTable(tweets, error);
                }
            }
        } else if self.timelineType == .Mentions {
//            TwitterClient.sharedInstance.mentionsTimelineWithCompletion(params: nil) { (tweets, error) -> () in
//                self.refreshControl.endRefreshing()
//                self.refreshTable(tweets, error);
//            }
        }
    }
    
    @objc func menuButtonPressed(sender: Any) {
        self.delegate?.toggleMenu(view: self.view, sender: sender)
    }
    
    // MARK: - TableViewController
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetTableViewCell
        let tweet = tweets?[indexPath.row]
        cell.delegate = self;
        cell.tweet = tweet;
        cell.profileImageView.setImageWith(URL(string: (tweet?.user?.profileImageUrl!)!)!)
        cell.userNameLabel.text = tweet?.user?.name!
        cell.screenNameLabel.text = "@\((tweet?.user?.screenname)!)"
        cell.tweetTextLabel.text = tweet?.text!
        cell.tweetCreatedAtLabel.text = formatTimeElapsed(sinceDate: tweet?.createdAt)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showTweetDetails", sender: self);
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func formatTimeElapsed(sinceDate: Date?) -> String {
        if let date = sinceDate {
            self.formatter.unitsStyle = DateComponentsFormatter.UnitsStyle.abbreviated
            self.formatter.collapsesLargestUnit = true
            self.formatter.maximumUnitCount = 1
            let interval = Date().timeIntervalSince(date as Date)
            return self.formatter.string(from: interval)!
        }
        return ""
    }
    
    // MARK: - Tweet Cell Delegate
    func openProfile(user: User) {
        let profileVC = TwitterProfileViewController()
        profileVC.user = user
        let navVC = UINavigationController(rootViewController: profileVC)
        self.present(navVC, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showTweetDetails") {
            let vc = segue.destination as! TweetDetailsViewController
            let tweet = tweets?[(tableView.indexPathForSelectedRow?.row)!]
            vc.tweet = tweet;
        }
    }

}
