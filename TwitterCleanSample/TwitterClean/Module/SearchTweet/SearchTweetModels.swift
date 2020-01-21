//
//  SearchTweetModels.swift
//  TwitterClean
//
//  Created by Ravi Prakash Sahu on 20/01/20.
//  Copyright (c) 2020 Ravi Prakash Sahu. All rights reserved.
//

import UIKit

struct SearchTweetModel {
	
	struct SearchRequest {
        let searchWord: String
        let frequency: Int
        
        init(searchWord:String, frequency: Int) {
            self.searchWord = searchWord
            self.frequency = frequency
        }
    }

	struct TwitterCellViewModel {
        let userID: Int
        let name: String
        let screenName: String
        let tweet: String
        let imageURL: String?
        
        init (tweet: Tweet) {
            self.userID = tweet.user.userId
            self.name = tweet.user.name
            self.screenName = tweet.user.screenName
            self.tweet = tweet.text
            if let profileImage = tweet.user.profileImage {
                self.imageURL = profileImage
            }
            else {
                self.imageURL = nil
            }
        }
    }
    
    struct SearchResponse: Codable {
        let tweets: [Tweet]?
        let metaData: MetaData?
        
        enum CodingKeys: String, CodingKey {
            case tweets = "statuses"
            case metaData = "search_metadata"
        }
    }
    
    struct Tweet: Codable {
        let tweetId: Int
        let text: String
        let user: User
        
        enum CodingKeys: String, CodingKey {
            case tweetId = "id"
            case text
            case user
        }
    }
    
    struct MetaData: Codable {
        var nextResult: String?
        var refreshURL: String?
        
        enum CodingKeys: String, CodingKey {
            case nextResult = "next_results"
            case refreshURL = "refresh_url"
        }
    }
    
    struct User: Codable {
        let userId: Int
        let name: String
        let screenName: String
        let profileImage: String?
        
        enum CodingKeys: String, CodingKey {
            case userId = "id"
            case name
            case screenName = "screen_name"
            case profileImage = "profile_image_url_https"
        }
    }
}
