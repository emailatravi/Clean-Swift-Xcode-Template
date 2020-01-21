//
//  SearchTweetPresenter.swift
//  TwitterClean
//
//  Created by Ravi Prakash Sahu on 20/01/20.
//  Copyright (c) 2020 Ravi Prakash Sahu. All rights reserved.
//

import UIKit

protocol SearchTweetPresenterProtocol: class {
	func resetData()
    func updateTweets(tweets: [SearchTweetModel.Tweet])
    func nextPageTweets(tweets: [SearchTweetModel.Tweet])
    func searchTweetsError(error: Error)
}

class SearchTweetPresenter {
	weak var view: SearchTweetViewControllerProtocol?
    
    var dataArray:[SearchTweetModel.TwitterCellViewModel] = []
	
	init(view: SearchTweetViewControllerProtocol?) {
		self.view = view
	}
}

extension SearchTweetPresenter: SearchTweetPresenterProtocol {
    func resetData() {
        self.dataArray = []
    }
    
    func updateTweets(tweets: [SearchTweetModel.Tweet]) {
        let tweetsViewModel = tweets.map({ tweet -> SearchTweetModel.TwitterCellViewModel in
            return SearchTweetModel.TwitterCellViewModel.init(tweet: tweet)
        })
        
        for tweet in tweetsViewModel.reversed() {
            dataArray.insert(tweet, at: 0)
        }
        
        let startRange: Int = 0
        let endRange: Int = tweetsViewModel.count
        
        var indexPaths: [IndexPath] = []
        
        for row in startRange..<endRange {
            indexPaths.append(IndexPath.init(row: row, section: 0))
        }
        
        view?.updateTweets(dataArray: self.dataArray, indexPaths: indexPaths)
    }
    
    func nextPageTweets(tweets: [SearchTweetModel.Tweet]) {
        let tweetsViewModel = tweets.map({ tweet -> SearchTweetModel.TwitterCellViewModel in
            return SearchTweetModel.TwitterCellViewModel.init(tweet: tweet)
        })
        
        let startRange: Int = self.dataArray.count
        let endRange = startRange + tweetsViewModel.count
        
        var indexPaths: [IndexPath] = []
        
        for row in startRange..<endRange {
            indexPaths.append(IndexPath.init(row: row, section: 0))
        }
        
        // Append data at end
        dataArray.append(contentsOf: tweetsViewModel)
        
        view?.updateTweets(dataArray: self.dataArray, indexPaths: indexPaths)
    }
    
    func searchTweetsError(error: Error) {
        view?.showTweetsError(error: error)
    }
}
