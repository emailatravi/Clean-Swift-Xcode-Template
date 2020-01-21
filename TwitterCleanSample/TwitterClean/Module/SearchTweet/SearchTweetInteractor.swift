//
//  SearchTweetInteractor.swift
//  TwitterClean
//
//  Created by Ravi Prakash Sahu on 20/01/20.
//  Copyright (c) 2020 Ravi Prakash Sahu. All rights reserved.
//

import UIKit

protocol SearchTweetInteractorProtocol: class {
	var searchClient: TWSearchClient? { get set }

    func fecthTweetsForWord(requestModel: SearchTweetModel.SearchRequest)
    func fecthNextPageTweets()
    func pauseAllFetch()
    func resumeAllFetch()
    func cancelAllFetch()
}

class SearchTweetInteractor {
    var presenter: SearchTweetPresenterProtocol?
    var searchClient: TWSearchClient?
    
    var newTweetFetchFrequency: Int = 5
    var needToFetchLatest: Bool = false

    init(presenter: SearchTweetPresenterProtocol) {
    	self.presenter = presenter
    }
    
    private func startFetchingLatestNews() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(newTweetFetchFrequency)) {
            // Check if need to fetch flag is still required
            if self.needToFetchLatest {
                self.getLatestTweets()
            }
        }
    }
    
    private func getLatestTweets() {
        searchClient?.getLatestTweets {[weak self] (tweets, _) -> (Void) in
            if let tweets = tweets, self?.needToFetchLatest ?? false {
                self?.presenter?.updateTweets(tweets: tweets)
                // Rertart timer
                self?.startFetchingLatestNews()
            }
        }
    }
}

extension SearchTweetInteractor: SearchTweetInteractorProtocol {
    func fecthTweetsForWord(requestModel: SearchTweetModel.SearchRequest) {
        // Reset Presenter Data
        presenter?.resetData()
        
        self.newTweetFetchFrequency = requestModel.frequency
        self.needToFetchLatest = true
        
        self.searchClient?.searchForWord(word: requestModel.searchWord) {[weak self] (tweets, error) -> (Void) in
            if let tweets = tweets {
                self?.presenter?.updateTweets(tweets: tweets)
                // Start fetching Latest News
                self?.startFetchingLatestNews()
                return
            }
            
            if let error = error {
                self?.presenter?.searchTweetsError(error: error)
                return
            }
            else {
                self?.presenter?.searchTweetsError(error: noDataError)
                return
            }
            
            self?.presenter?.searchTweetsError(error: oopsError)
        }
    }
    
    func fecthNextPageTweets() {
        searchClient?.getPreviousTweets {[weak self] (tweets, _) -> (Void) in
            if let tweets = tweets {
                self?.presenter?.nextPageTweets(tweets: tweets)
                return
            }
        }
    }
    
    func pauseAllFetch() {
        searchClient?.cancelAllTasks()
        needToFetchLatest = false
    }
    
    func resumeAllFetch() {
        self.needToFetchLatest = true
        startFetchingLatestNews()
    }
    
    func cancelAllFetch() {
        searchClient?.cancelAllTasks()
        needToFetchLatest = false
    }
}
