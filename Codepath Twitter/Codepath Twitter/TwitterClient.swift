//
//  TwitterClient.swift
//  Codepath Twitter
//
//  Created by admin on 10/2/15.
//  Copyright © 2015 mattmo. All rights reserved.
//

import UIKit
import AFNetworking
import BDBOAuth1Manager

struct Credentials {
    static let defaultCredentialsFile = "Credentials"
    static let defaultCredentials     = Credentials.loadFromPropertyListNamed(name: defaultCredentialsFile)
    
    let consumerKey: String
    let consumerSecret: String
    
    private static func loadFromPropertyListNamed(name: String) -> Credentials {
        
        // You must add a Credentials.plist file
        let path           = Bundle.main.path(forResource: name, ofType: "plist")!
        let dictionary     = NSDictionary(contentsOfFile: path)!
        let consumerKey    = dictionary["ConsumerKey"] as! String
        let consumerSecret = dictionary["ConsumerSecret"] as! String
        
        return Credentials(consumerKey: consumerKey, consumerSecret: consumerSecret)
    }
}

let sharedTwitterClient = TwitterClient(baseURL: URL(string: "https://api.twitter.com")!,
                                        consumerKey: Credentials.defaultCredentials.consumerKey,
                                        consumerSecret:Credentials.defaultCredentials.consumerSecret)

class TwitterClient: BDBOAuth1RequestOperationManager {
    static let baseUrl = URL(string: "https://api.twitter.com")!;
    var accessToken: String!;
    var accessSecret: String!;

    var loginCompletion: ((User?, Error?) -> ())?
    
    override init(baseURL: URL, consumerKey: String, consumerSecret: String) {
        super.init(baseURL: baseURL, consumerKey: consumerKey, consumerSecret: consumerSecret)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//
//    func retweetWithCompletion(id: Int, completion: (tweet: Tweet?, error: NSError?) -> ()) {
//        POST("1.1/statuses/retweet/\(id).json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: Any!) -> Void in
//            print("Successfully retweeted")
//            print(response)
//            let tweet = Tweet(dictionary: response as! NSDictionary)
//            completion(tweet: tweet, error: nil)
//        }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
//            print("error: \(error)");
//            completion(tweet: nil, error: error)
//        }
//    }
//    
//    func favoriteWithCompletion(state: Bool, params: NSDictionary?, completion: (error: NSError?) -> ()) {
//        let endpoint = (state) ? "1.1/favorites/create.json" : "1.1/favorites/destroy.json"
//        POST(endpoint, parameters: params, success: { (operation: AFHTTPRequestOperation!, response: Any!) -> Void in
//            print(response)
//            completion(error: nil)
//        }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
//            completion(error: error)
//        }
//    }
//    
//    func composeTweetWithCompletion(params: NSDictionary?, completion: (tweet: Tweet?, error: NSError?) -> ()) {
//        POST("1.1/statuses/update.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: Any!) -> Void in
//            //
//            print(response)
//            let tweet = Tweet(dictionary: response as! NSDictionary)
//            completion(tweet: tweet, error: nil)
//        }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
//            //
//            print("error composing tweet")
//            completion(tweet: nil, error: error)
//        }
//    }
//    
//    func mentionsTimelineWithCompletion(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
//        GET("1.1/statuses/mentions_timeline.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: Any!) -> Void in
//            let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
//            for tweet in tweets {
//                print("text: \(tweet.text), created: \(tweet.createdAtString)")
//            }
//            completion(tweets: tweets, error: nil)
//            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
//                print("error getting mentions timeline")
//                completion(tweets: nil, error: error)
//        })
//    }
//    
    func homeTimelineWithCompletion(params: NSDictionary?, completion: ((_ tweets: [Tweet]?, _ error: Error?) -> ())?) {
        get("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: Any!) -> Void in
            let tweets = Tweet.tweetsWithArray(array: response as! [NSDictionary])
            for tweet in tweets {
                print("text: \(tweet.text), created: \(tweet.createdAtString)")
            }
            
            guard let completion = completion else {
                return
            }
            completion(tweets, nil)
        }, failure: { (operation: AFHTTPRequestOperation, error: Error) -> Void in
            print("error getting hometimeline")
            
            guard let completion = completion else {
                return
            }
            completion(nil, error)
        })
    }

    func loginWithCompletion(completion: @escaping (_ user: User?,_ error: Error?) -> ()) {
        loginCompletion = completion
        
        // Fetch request token & redirect to authorization page
        sharedTwitterClient.requestSerializer.removeAccessToken();
        sharedTwitterClient.fetchRequestToken(withPath: "oauth/request_token", method: "POST", callbackURL: URL(string:"cptwitterdemo://"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void in
            print("Got Request Token")
            guard let token = requestToken?.token else {
                return;
            }
            guard let authURL = URL(string: "\(TwitterClient.baseUrl)/oauth/authorize?oauth_token=\(token)") else {
                return;
            }
            
            UIApplication.shared.openURL(authURL);
            }) { (error: Error?) -> Void in
                print("Error: \(error)");
                self.loginCompletion?(nil, error);
            };
    }

    func openURL(url: URL) {
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("Successfully retrieved access token");
            sharedTwitterClient.requestSerializer.saveAccessToken(accessToken);
            
            sharedTwitterClient.get("1.1/account/verify_credentials.json", parameters: nil, success:
                { (operation: AFHTTPRequestOperation!, response: Any!) -> Void in
                    //print("Successfully verified credentials: \(response)");
                    var user = User(dictionary: response as! NSDictionary)
                    print("user: \(user.name)")
                    User.currentUser = user
                    self.loginCompletion?(user, nil)
                }, failure: { (operation: AFHTTPRequestOperation, error: Error) -> Void in
                    print("Error verifying credentials: \(error)")
                    self.loginCompletion?(nil, error)
            })
        }) { (error: Error?) -> Void in
            print("Failed to receive access token: \(error)");
            self.loginCompletion?(nil, error)
        }
    }
}
