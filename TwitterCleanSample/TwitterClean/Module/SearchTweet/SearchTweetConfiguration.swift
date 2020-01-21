//
//  SearchTweetConfiguration.swift
//  TwitterClean
//
//  Created by Ravi Prakash Sahu on 20/01/20.
//  Copyright (c) 2020 Ravi Prakash Sahu. All rights reserved.
//

import Foundation
import UIKit

class SearchTweetConfiguration {
    static func setup(searchClient: TWSearchClient) -> UIViewController {
        let controller = SearchTweetViewController()
        let router = SearchTweetRouter(view: controller)
        let presenter = SearchTweetPresenter(view: controller)
        let interactor = SearchTweetInteractor(presenter: presenter)
        
        controller.interactor = interactor
        controller.router = router
        interactor.searchClient = searchClient
        return controller
    }
}
