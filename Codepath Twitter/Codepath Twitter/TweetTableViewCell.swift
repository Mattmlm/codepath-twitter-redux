//
//  TweetTableViewCell.swift
//  Codepath Twitter
//
//  Created by admin on 10/11/15.
//  Copyright © 2015 mattmo. All rights reserved.
//

import UIKit

protocol TweetCellDelegate: class {
    func openProfile(user: User)
}

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetCreatedAtLabel: UILabel!
    
    var tweet: Tweet!
    weak var delegate: TweetCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profileImageView.userInteractionEnabled = true;
        let singleTap = UITapGestureRecognizer(target: self, action: "openProfile")
        singleTap.numberOfTapsRequired = 1
        profileImageView.addGestureRecognizer(singleTap)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func openProfile() {
        self.delegate?.openProfile(tweet.user!)
    }
}
