//
//  UserTweetInteractor.swift
//  TwitterClean
//
//  Created by Ravi Prakash Sahu on 20/01/20.
//  Copyright (c) 2020 Ravi Prakash Sahu. All rights reserved.
//

import UIKit

protocol UserTweetInteractorProtocol: class {
    var user: UserTweetModel.User? {get set}

	func fetchUserTweets()
}

class UserTweetInteractor: UserTweetInteractorProtocol {
    var presenter: UserTweetPresenterProtocol?
    var userClient: TWUserClient?
    var user: UserTweetModel.User?

    init(presenter: UserTweetPresenterProtocol) {
    	self.presenter = presenter
    }

    func fetchUserTweets() {
        userClient?.getTweets(completionHandler: { (tweets, error) -> (Void) in
            if let error = error {
                self.presenter?.showError(error: error)
            }
            
            if let tweets = tweets {
                self.presenter?.processUserTweets(responseModel: tweets)
            }
        })
    }
}
