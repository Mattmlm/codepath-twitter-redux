//
//  User.swift
//  Codepath Twitter
//
//  Created by admin on 10/2/15.
//  Copyright © 2015 mattmo. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
  var name: String?
  var screenname: String?
  var profileImageUrl: String?
    var profileBackgroundImageUrl: String?
  var tagline: String?
    var tweetsCount: Int?
    var followingCount: Int?
    var followersCount: Int?
  var dictionary: NSDictionary
  
  init(dictionary: NSDictionary) {
    self.dictionary = dictionary
    name = dictionary["name"] as? String
    screenname = dictionary["screen_name"] as? String
    profileImageUrl = dictionary["profile_image_url"] as? String
    profileBackgroundImageUrl = dictionary["profile_background_image_url"] as? String
    tweetsCount = dictionary["statuses_count"] as? Int
    followingCount = dictionary["friends_count"] as? Int
    followersCount = dictionary["followers_count"] as? Int
    tagline = dictionary["description"] as? String
  }

    func logout() {
//        User.currentUser = nil
//        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
//
//        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object:nil)
    }

  class var currentUser: User? {
    get {
      if _currentUser == nil {
        if let data = UserDefaults.standard.object(forKey: currentUserKey) as? Data {
          do {
            let dictionary = try JSONSerialization.jsonObject(with: data, options: [])
            _currentUser = User(dictionary: dictionary as! NSDictionary);
          } catch {
            print("Error: \(error)")
          }
        }
      }
      return _currentUser
    }
    set(user) {
      _currentUser = user

      if _currentUser != nil {
        do {
            let data = try JSONSerialization.data(withJSONObject: user!.dictionary, options: [])
            UserDefaults.standard.set(data, forKey: currentUserKey)
        } catch {
          print("Error: \(error)")
        }
      } else {
        UserDefaults.standard.set(nil, forKey: currentUserKey)
      }
      UserDefaults.standard.synchronize()
    }
  }
}
