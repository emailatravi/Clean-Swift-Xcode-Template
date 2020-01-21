//
//  UserTweetModels.swift
//  TwitterClean
//
//  Created by Ravi Prakash Sahu on 20/01/20.
//  Copyright (c) 2020 Ravi Prakash Sahu. All rights reserved.
//

import UIKit

struct UserTweetModel {	
	
	struct User: Codable {
        let userId: Int
        let name: String
        let screenName: String
        let profileImage: String?
        
        init(userId: Int, name: String, screenName: String, profileImage: String?) {
            self.userId = userId
            self.name = name
            self.screenName = screenName
            self.profileImage = profileImage
        }
    }

	struct UserTweetCellViewModel {
        let text: String
        
        init(userTweet: UserTweet) {
            self.text = userTweet.text
        }
    }
    
    struct UserTweet: Codable {
        let tweetId: Int
        let text: String
        
        enum CodingKeys: String, CodingKey {
            case tweetId = "id"
            case text
        }
    }
}
