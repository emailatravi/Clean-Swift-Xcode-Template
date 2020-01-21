//
//  TWUserClient.swift
//  AirtelAssigment
//
//  Created by Ravi Prakash Sahu on 04/01/20.
//  Copyright © 2020 Ravi Prakash Sahu. All rights reserved.
//

import Foundation

class TWUserClient {
    typealias twUserTweetsCompletionBlock = (_ tweets: [UserTweetModel.UserTweet]?, _ error: Error?) -> (Void)

    private let userId: Int
    // Create Data Downloader
    private let downloader:DataDownloader
    // Create Data Session Task Store
    private let dataTaskSotre:DataTaskStore
    
    init(userId: Int, downloader: DataDownloader = DataDownloader(), dataTaskSotre: DataTaskStore = DataTaskStore()) {
        self.userId = userId
        self.downloader = downloader
        self.dataTaskSotre = dataTaskSotre
    }
    
    public func cancelTaskIfAny() {
        dataTaskSotre.cancelAllTask()
    }
    
    public func getTweets(completionHandler completion: @escaping twUserTweetsCompletionBlock) {
        let queryURL = URLProvider.getUserTweetsURL(userId: userId, tweetsCount: 100)
        if let url = URL(string: queryURL) {
            var urlRequest = URLRequest(url: url)
            urlRequest.addValue(Constants.authString, forHTTPHeaderField: "Authorization")
            let dataTask = downloader.dataTask(with: urlRequest) {[weak self] (data, error) in
                // Remove task from dataTaskSotre
                self?.dataTaskSotre.cancelTask(hash: urlRequest.url!.absoluteString)
                
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                DispatchQueue.global().async {
                    do {
                        //let jsonData = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                        let tweetData = try JSONDecoder().decode([UserTweetModel.UserTweet].self, from: data!)
                        DispatchQueue.main.async {
                            if tweetData.count == 0 {
                                completion(nil, nil)
                            }
                            else {
                                completion(tweetData, nil)
                            }
                        }
                    }
                    catch {
                        completion(nil, error)
                    }
                }
            }
            
            // Add task to store
            dataTaskSotre.addTask(hash:urlRequest.url!.absoluteString, urlSessionTask: dataTask)
            
            dataTask.resume()
        }
        else {
            completion(nil, badURLError)
        }
    }
}
