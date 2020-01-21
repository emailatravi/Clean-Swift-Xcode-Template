//
//  ImageDownloader.swift
//  AirtelAssigment
//
//  Created by Ravi Prakash Sahu on 04/01/20.
//  Copyright © 2020 Ravi Prakash Sahu. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    typealias SuccessCompletion = (Bool) -> ()
    func loadImageWith(_ URLString: String, placeHolder: UIImage?, completion: @escaping SuccessCompletion) {
        self.image = nil
        if let cachedImage = ImageDownloader.sharedInstance.imageCache.object(forKey: NSString(string: URLString)) {
            DispatchQueue.main.async {
                self.image = cachedImage
                completion(true)
            }
            return
        }
        
        self.image = placeHolder
        
        // Cancel task before adding
        ImageDownloader.sharedInstance.dataTaskSotre.cancelTask(hash: String(self.hashValue))
        
        if let url = URL(string: URLString) {
            let urlRequest = URLRequest(url: url)
            let task = ImageDownloader.sharedInstance.downloader.dataTask(with: urlRequest) { (data, error) in
                if let error = error {
                    debugPrint(error.localizedDescription)
                }
                ImageDownloader.sharedInstance.dataTaskSotre.removeTask(hash: String(self.hashValue))
                
                if let data = data {
                    if let downloadedImage = UIImage(data: data) {
                        ImageDownloader.sharedInstance.imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                        DispatchQueue.main.async {
                            self.image = downloadedImage
                            completion(true)
                        }
                    }
                    else {
                        DispatchQueue.main.async {
                            self.image = placeHolder
                            completion(false)
                        }
                    }
                }
                else {
                    DispatchQueue.main.async {
                        self.image = placeHolder
                        completion(false)
                    }
                }
            }
            
            ImageDownloader.sharedInstance.dataTaskSotre.addTask(hash: String(self.hashValue), urlSessionTask: task)
            
            task.resume()
        } else {
            self.image = placeHolder
        }
    }
}
