//
//  ComposeTweetViewController.swift
//  Codepath Twitter
//
//  Created by admin on 10/4/15.
//  Copyright © 2015 mattmo. All rights reserved.
//

import UIKit



class ComposeTweetViewController: UIViewController {

    @IBOutlet weak var tweetField: UITextField!
    
    var replyToTweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor(rgba: "#55ACEE");
        self.navigationController?.navigationBar.isTranslucent = false;
        self.navigationController?.navigationBar.tintColor = UIColor.white;

        if replyToTweet != nil {
            self.tweetField.text = "@\((replyToTweet!.user?.screenname)!) "
        }
        
        self.tweetField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelButtonPressed(sender: Any) {
        dismiss(animated: true, completion: nil);
    }

    @IBAction func onTweetButtonPressed(sender: Any) {
//        let dict = NSMutableDictionary()
//        dict["status"] = tweetField.text!
//        if replyToTweet != nil {
//            dict["in_reply_to_status_id"] = replyToTweet!.idString!
//        }
//        TwitterClient.sharedInstance.composeTweetWithCompletion(dict) { (tweet, error) -> () in
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                self.dismiss(animated:true, completion: nil);
//            })
//        }
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
