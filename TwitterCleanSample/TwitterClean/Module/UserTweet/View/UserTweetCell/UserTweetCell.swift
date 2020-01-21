//
//  UserTweetCell.swift
//  AirtelAssigment
//
//  Created by Ravi Prakash Sahu on 04/01/20.
//  Copyright © 2020 Ravi Prakash Sahu. All rights reserved.
//

import UIKit

class UserTweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        tweetText.text = ""
    }
    
    func bind(viewModel: UserTweetModel.UserTweetCellViewModel) {
        tweetText.text = viewModel.text
    }
}
