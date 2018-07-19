//
//  TweetDetailsViewController.swift
//  Codepath Twitter
//
//  Created by admin on 10/4/15.
//  Copyright © 2015 mattmo. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {
    
    var tweet: Tweet!

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetCreatedAtLabel: UILabel!
    @IBOutlet weak var tweetRetweetsCountLabel: UILabel!
    @IBOutlet weak var tweetRetweetsLabel: UILabel!
    @IBOutlet weak var tweetFavoritesCountLabel: UILabel!
    @IBOutlet weak var tweetFavoritesLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tweet"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor(rgba: "#55ACEE");
        self.navigationController?.navigationBar.isTranslucent = false;
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        
        self.profileImageView.setImageWith(URL(string:(self.tweet.user?.profileImageUrl)!)!)
        self.userNameLabel.text = self.tweet.user?.name!
        self.screenNameLabel.text = "@\((self.tweet.user?.screenname)!)"
        self.tweetTextLabel.text = self.tweet.text!
        self.favoriteButton.isSelected = self.tweet.favorited!
        
        TweetDateFormatter.setDateFormatterForTweetDetails()
        self.tweetCreatedAtLabel.text = TweetDateFormatter.shared.string(from: self.tweet.createdAt!);
        
        self.tweetRetweetsCountLabel.text = "\(self.tweet.retweetCount!)"
        self.tweetFavoritesCountLabel.text = "\(self.tweet.favoriteCount!)"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onReplyButtonPressed(sender: Any) {
        
    }
    
    @IBAction func onRetweetButtonPressed(sender: Any) {
//        TwitterClient.sharedInstance.retweetWithCompletion(self.tweet.id!) { (tweet, error) -> () in
//            if (tweet != nil) {
//                let alert: UIAlertController = UIAlertController(title: "Retweeted!", message: nil, preferredStyle: .Alert)
//                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
//
//                alert.addAction(defaultAction);
//                self.presentViewController(alert, animated: true, completion: nil)
//            } else if (error != nil) {
//                let alert: UIAlertController = UIAlertController(title: "There was an error retweeting", message: error!.userInfo["error"] as? String, preferredStyle: .Alert)
//                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
//
//                alert.addAction(defaultAction);
//                self.presentViewController(alert, animated: true, completion: nil)
//            }
//        }
    }
    
    @IBAction func onFavoriteButtonPressed(sender: Any) {
//        self.tweet.favorited = !self.favoriteButton.isSelected
//        self.favoriteButton.isSelected = !self.favoriteButton.isSelected
//        if (self.favoriteButton.isSelected) {
//            self.tweet.favoriteCount!++
//        } else {
//            self.tweet.favoriteCount!--
//        }
//        self.tweetFavoritesCountLabel.text = "\(self.tweet.favoriteCount!)"
//        let params = NSDictionary(object: self.tweet.id!, forKey: "id")
//        TwitterClient.sharedInstance.favoriteWithCompletion(self.favoriteButton.isSelected, params: params) { (error) -> () in
//            if (error == nil) {
//                let alert: UIAlertController = UIAlertController(title: "Favorited!", message: nil, preferredStyle: .Alert)
//                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
//                alert.addAction(defaultAction);
//                self.presentViewController(alert, animated: true, completion: nil)
//            } else if (error != nil) {
//                let alert: UIAlertController = UIAlertController(title: "There was an error favoriting", message: error!.userInfo["error"] as? String, preferredStyle: .Alert)
//                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
//                alert.addAction(defaultAction);
//                self.presentViewController(alert, animated: true, completion: nil)
//            }
//        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "replyToTweet") {
            let navVC = segue.destination as! UINavigationController
            let vc = navVC.topViewController as! ComposeTweetViewController
            vc.replyToTweet = self.tweet;
        }
    }

}
