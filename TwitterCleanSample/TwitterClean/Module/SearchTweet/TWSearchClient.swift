//
//  TWSearchClient.swift
//  AirtelAssigment
//
//  Created by Ravi Prakash Sahu on 04/01/20.
//  Copyright © 2020 Ravi Prakash Sahu. All rights reserved.
//

import Foundation

class TWSearchClient {
    typealias twSearchCompletionBlock = (_ tweets: [SearchTweetModel.Tweet]?, _ error: Error?) -> (Void)
    
    private let authString: String
    // Create Data Downloader
    private let downloader:DataDownloader
    // Create Data Session Task Store
    private let dataTaskSotre:DataTaskStore

    private var metaData: SearchTweetModel.MetaData?
    
    init(authString: String, downloader: DataDownloader = DataDownloader(), dataTaskSotre: DataTaskStore = DataTaskStore()) {
        self.authString = authString
        self.downloader = downloader
        self.dataTaskSotre = dataTaskSotre
    }
    
    private func executeRequest(urlRequest: URLRequest,
                                       updateNextURL: Bool,
                                       updateRefreshURL: Bool,
                                       completion: @escaping twSearchCompletionBlock) {
        // Check this request is already executing or not
        if dataTaskSotre.isRequestExecuting(hash: urlRequest.url!.absoluteString) {
            // Request is executing...
            completion(nil, requestInProgressError)
            return
        }
        
        let dataTask = downloader.dataTask(with: urlRequest) {[weak self] (data, error) in
            // Remove task from dataTaskSotre
            self?.dataTaskSotre.removeTask(hash: urlRequest.url!.absoluteString)
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            DispatchQueue.global().async {
                do {
                    //let jsonData = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                    let tweetData = try JSONDecoder().decode(SearchTweetModel.SearchResponse.self, from: data!)
                    DispatchQueue.main.async {
                        if tweetData.tweets!.count == 0 {
                            completion(nil, nil)
                        }
                        else {
                            // Set meta data
                            if self?.metaData == nil {
                                self?.metaData = tweetData.metaData!
                            }
                            else {
                                if updateNextURL {
                                    self?.metaData?.nextResult = tweetData.metaData!.nextResult
                                }
                                if updateRefreshURL {
                                    self?.metaData?.refreshURL = tweetData.metaData!.refreshURL
                                }
                            }
                            completion(tweetData.tweets!, nil)
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
        
        // Execute session task
        dataTask.resume()
    }
}

extension TWSearchClient {
    public func cancelAllTasks() {
        // Cancel All tasks
        dataTaskSotre.cancelAllTask()
    }
    
    public func pauseAllTasks() {
        // Cancel All tasks
        dataTaskSotre.pauseAllTask()
    }
    
    public func resumeAllTasks() {
        // Cancel All tasks
        dataTaskSotre.resumeAllTask()
    }
    
    public func searchForWord(word: String, completion: @escaping twSearchCompletionBlock) {
        // Cancel All tasks 
        dataTaskSotre.cancelAllTask()
        // Remove metaData
        metaData = nil
        
        let queryURL = URLProvider.getSerchURL(searchString: word.trimmingCharacters(in: .whitespaces))
        
        if let url = URL(string: queryURL) {
            var urlRequest = URLRequest(url: url)
            urlRequest.addValue(authString, forHTTPHeaderField: "Authorization")
            executeRequest(urlRequest: urlRequest, updateNextURL: true, updateRefreshURL: true) { (jsonData, error) -> (Void) in
                completion(jsonData, error)
            }
        }
        else {
            completion(nil, badURLError)
        }
    }
    
    public func getPreviousTweets(completionHandler completion: @escaping twSearchCompletionBlock) {
        if let metaData = metaData {
            let queryURL = URLProvider.getSearchParamURL(queryParameter: metaData.nextResult!)
            if let url = URL(string: queryURL) {
                var urlRequest = URLRequest(url: url)
                urlRequest.addValue(authString, forHTTPHeaderField: "Authorization")
                executeRequest(urlRequest: urlRequest, updateNextURL: true, updateRefreshURL: false) { (jsonData, error) -> (Void) in
                    completion(jsonData, error)
                }
            }
            else {
                completion(nil, badURLError)
            }
        }
        else {
            completion(nil, oopsError)
        }
    }
    
    public func getLatestTweets(completionHandler completion: @escaping twSearchCompletionBlock) {
        if let metaData = metaData {
            let queryURL = URLProvider.getSearchParamURL(queryParameter: metaData.refreshURL!)
            if let url = URL(string: queryURL) {
                var urlRequest = URLRequest(url: url)
                urlRequest.addValue(authString, forHTTPHeaderField: "Authorization")
                executeRequest(urlRequest: urlRequest, updateNextURL: false, updateRefreshURL: true) { (jsonData, error) -> (Void) in
                    completion(jsonData, error)
                }
            }
            else {
                completion(nil, badURLError)
            }
        }
        else {
            completion(nil, oopsError)
        }
    }
}
