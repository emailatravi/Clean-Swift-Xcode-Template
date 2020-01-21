//
//  UserTweetViewController.swift
//  TwitterClean
//
//  Created by Ravi Prakash Sahu on 20/01/20.
//  Copyright (c) 2020 Ravi Prakash Sahu. All rights reserved.
//

import UIKit

protocol UserTweetViewControllerProtocol: class {
	var router: UserTweetRouterProtocol? { get set }

	func showUserTweets(viewModel: [UserTweetModel.UserTweetCellViewModel])
    func showError(error: Error)
}

class UserTweetViewController: UIViewController {
	var interactor: UserTweetInteractorProtocol?
	var router: UserTweetRouterProtocol?
    
    @IBOutlet weak var tableView: UITableView!
    
    private let cellIdentifier: String = "UserTweetCell"
    var dataArray:[UserTweetModel.UserTweetCellViewModel] = []

	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        
        // Register nib
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        self.title = interactor?.user?.screenName
        
        interactor?.fetchUserTweets()
    }
}

extension UserTweetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UserTweetCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! UserTweetCell
        cell.bind(viewModel: dataArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension UserTweetViewController: UserTweetViewControllerProtocol {
	
	func showUserTweets(viewModel: [UserTweetModel.UserTweetCellViewModel]) {
		dataArray = viewModel
        tableView.reloadData()
	}
    
    func showError(error: Error) {
        
    }
}
