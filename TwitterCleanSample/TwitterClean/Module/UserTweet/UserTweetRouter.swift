//
//  UserTweetRouter.swift
//  TwitterClean
//
//  Created by Ravi Prakash Sahu on 20/01/20.
//  Copyright (c) 2020 Ravi Prakash Sahu. All rights reserved.
//

import UIKit

protocol UserTweetRouterProtocol: class {
	// do someting...
}

class UserTweetRouter: UserTweetRouterProtocol {	
	weak var view: UserTweetViewController?
	
	init(view: UserTweetViewController?) {
		self.view = view
	}
}
