//
//  TwitterCell.swift
//  AirtelAssigment
//
//  Created by Ravi Prakash Sahu on 04/01/20.
//  Copyright © 2020 Ravi Prakash Sahu. All rights reserved.
//

import UIKit

class TwitterCell: UITableViewCell {
    
    private let placeHolder: UIImage = UIImage(named: "user_placeholder")!

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var tweet: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        name.text = ""
        screenName.text = ""
        tweet.text = ""
        
        profileImage.image = placeHolder
    }
    
    func bind(viewModel: SearchTweetModel.TwitterCellViewModel) {
        name.text = viewModel.name
        screenName.text = viewModel.screenName
        tweet.text = viewModel.tweet
        
        if let imageURL = viewModel.imageURL {
            profileImage.loadImageWith(imageURL, placeHolder: placeHolder) { status in
                // 
            }
        }
    }
    
}
