//
//  SearchTweetViewController.swift
//  TwitterClean
//
//  Created by Ravi Prakash Sahu on 20/01/20.
//  Copyright (c) 2020 Ravi Prakash Sahu. All rights reserved.
//

import UIKit

protocol SearchTweetViewControllerProtocol: class {
	var router: SearchTweetRouterProtocol? { get set }

    func resetView()
    func updateTweets(dataArray: [SearchTweetModel.TwitterCellViewModel], indexPaths:[IndexPath])
    func showTweetsError(error: Error)
}

class SearchTweetViewController: UIViewController {
	var interactor: SearchTweetInteractorProtocol?
	var router: SearchTweetRouterProtocol?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private let cellIdentifier: String = "TwitterCell"
    var dataArray:[SearchTweetModel.TwitterCellViewModel] = []

	override func viewDidLoad() {
        super.viewDidLoad()
        
        // Reset views and data
        resetDataAndView()
        searchBar.becomeFirstResponder()
        // Register nib
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if dataArray.count > 0 {
            interactor?.resumeAllFetch()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if dataArray.count > 0 {
            interactor?.pauseAllFetch()
        }
    }
}

// MARK: Private Methods
extension SearchTweetViewController {
    func resetDataAndView() {
        // Reset data
        dataArray = []
        self.tableView.reloadData()
        self.tableView.isHidden = true
    }
}

// MARK: UITableViewDelegate & UITableViewDataSource Methods
extension SearchTweetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TwitterCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TwitterCell
        cell.bind(viewModel: dataArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let tweetViewModel = dataArray[indexPath.row]
        let user = SearchTweetModel.User(userId: tweetViewModel.userID, name: tweetViewModel.name, screenName: tweetViewModel.screenName, profileImage: tweetViewModel.imageURL)
        router?.showTweetsForUser(user: user)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Make pagination call
        if dataArray.count > 0 , dataArray.count - 1 == indexPath.row {
            interactor?.fecthNextPageTweets()
        }
    }
}

// MARK: UISearchBarDelegate Methods
extension SearchTweetViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            // Search has been cleared..
            resetDataAndView()
            interactor?.cancelAllFetch()
        }
    }
    
    // When search button hit, fetch results
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            let word = text.trimmingCharacters(in: .whitespaces)
            let requestModel = SearchTweetModel.SearchRequest(searchWord: word, frequency: 5)
            interactor?.fecthTweetsForWord(requestModel: requestModel)
        }
        
        // Hide keybord
        searchBar.resignFirstResponder()
    }
}

extension SearchTweetViewController: SearchTweetViewControllerProtocol {
	
    func resetView() {
        resetDataAndView()
    }
    
    func updateTweets(dataArray: [SearchTweetModel.TwitterCellViewModel], indexPaths:[IndexPath]) {
        if dataArray.count > 0 {
            if self.tableView.isHidden {
                self.tableView.isHidden = false
            }
            self.dataArray = dataArray
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: indexPaths, with: .none)
            self.tableView.endUpdates()
        }
    }
    
    func showTweetsError(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
