//
//  DataDownloader.swift
//  AirtelAssigment
//
//  Created by Ravi Prakash Sahu on 04/01/20.
//  Copyright © 2020 Ravi Prakash Sahu. All rights reserved.
//

import Foundation

struct DataDownloader {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    init() {
        self.init(configuration: .default)
    }
    
    typealias TaskCompletionHandler = (_ data: Data?, _ error: Error?) -> ()
    
    func dataTask(with request: URLRequest, completionHandler completion: @escaping TaskCompletionHandler) -> URLSessionTask {
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                if let error = error {
                    completion(nil, error)
                    return
                }
                completion(nil, oopsError)
                return
            }
            
            if httpResponse.statusCode != 200 {
                completion(nil, apiError(errorCode: httpResponse.statusCode))
                return
            }
            
            // Check if we have data
            if let data = data {
                DispatchQueue.main.async {
                    completion(data, nil)
                    return
                }
            }
            else {
                // If nothing, return generic error
                completion(nil, oopsError)
            }
        }
        
        return task
    }
}
