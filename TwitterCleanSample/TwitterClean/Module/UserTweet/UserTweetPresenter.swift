//
//  UserTweetPresenter.swift
//  TwitterClean
//
//  Created by Ravi Prakash Sahu on 20/01/20.
//  Copyright (c) 2020 Ravi Prakash Sahu. All rights reserved.
//

import UIKit

protocol UserTweetPresenterProtocol: class {
	func processUserTweets(responseModel: [UserTweetModel.UserTweet])
    func showError(error: Error)
}

class UserTweetPresenter: UserTweetPresenterProtocol {
	weak var view: UserTweetViewControllerProtocol?
	
	init(view: UserTweetViewControllerProtocol?) {
		self.view = view
	}

	func processUserTweets(responseModel: [UserTweetModel.UserTweet]) {
        let userTweets = responseModel.map { userTweet -> UserTweetModel.UserTweetCellViewModel in
            return UserTweetModel.UserTweetCellViewModel.init(userTweet: userTweet)
        }
        view?.showUserTweets(viewModel: userTweets)
	}
    
    func showError(error: Error) {
        
    }
}
