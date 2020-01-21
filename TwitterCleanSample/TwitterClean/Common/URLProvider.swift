//
//  URLProvider.swift
//  AirtelAssigment
//
//  Created by Ravi Prakash Sahu on 05/01/20.
//  Copyright © 2020 Ravi Prakash Sahu. All rights reserved.
//

import Foundation

class URLProvider {
    private init() {}
    
    #if DEBUG
    private static let baseURL = "https://api.twitter.com/1.1/"
    #else
    private static let baseURL = "https://api.twitter.com/1.1/"
    #endif
    
    class func getSerchURL(searchString: String) -> String {
        if let escapedString: String = searchString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            return baseURL + "search/tweets.json?q=\(escapedString)"
        }
        return baseURL + "search/tweets.json?q=\(searchString)"
    }
    
    class func getSearchParamURL(queryParameter: String) -> String {
        return baseURL + "search/tweets.json\(queryParameter)"
    }
    
    class func getUserTweetsURL(userId: Int, tweetsCount: Int) -> String {
        return baseURL + "statuses/user_timeline.json?user_id=\(userId)&trim_user=true&include_entities=false&count=\(tweetsCount)"
    }
}
