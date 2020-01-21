//
//  UserTweetConfiguration.swift
//  TwitterClean
//
//  Created by Ravi Prakash Sahu on 20/01/20.
//  Copyright (c) 2020 Ravi Prakash Sahu. All rights reserved.
//

import Foundation
import UIKit

class UserTweetConfiguration {
    static func setup(user: UserTweetModel.User) -> UIViewController {
        let controller = UserTweetViewController()
        let router = UserTweetRouter(view: controller)
        let presenter = UserTweetPresenter(view: controller)
        let interactor = UserTweetInteractor(presenter: presenter)
        
        controller.interactor = interactor
        controller.router = router
        interactor.user = user
        interactor.userClient = TWUserClient(userId: user.userId)
        return controller
    }
}
