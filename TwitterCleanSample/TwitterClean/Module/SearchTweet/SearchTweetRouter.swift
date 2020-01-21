//
//  SearchTweetRouter.swift
//  TwitterClean
//
//  Created by Ravi Prakash Sahu on 20/01/20.
//  Copyright (c) 2020 Ravi Prakash Sahu. All rights reserved.
//

import UIKit

protocol SearchTweetRouterProtocol: class {
    func showTweetsForUser(user: SearchTweetModel.User)
}

class SearchTweetRouter: SearchTweetRouterProtocol {
	weak var view: SearchTweetViewController?
	
	init(view: SearchTweetViewController?) {
		self.view = view
	}
    
    func showTweetsForUser(user: SearchTweetModel.User) {
        let vc = UserTweetConfiguration.setup(user: UserTweetModel.User(userId: user.userId, name: user.name, screenName: user.screenName, profileImage: user.profileImage))
        view?.navigationController?.pushViewController(vc, animated: true)
    }
}
