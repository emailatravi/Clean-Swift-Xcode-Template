//
//  ImageDownloader.swift
//  TwitterClean
//
//  Created by Ravi Prakash Sahu on 21/01/20.
//  Copyright © 2020 Ravi Prakash Sahu. All rights reserved.
//

import Foundation
import UIKit

class ImageDownloader {
    // Create Data Downloader
    let downloader:DataDownloader
    // Create image cache
    let imageCache: NSCache<NSString, UIImage>
    // Create Data Session Task Store
    let dataTaskSotre:DataTaskStore
    
    private init() {
        self.downloader = DataDownloader()
        self.imageCache = NSCache<NSString, UIImage>()
        self.dataTaskSotre = DataTaskStore()
    }
    
    static let sharedInstance: ImageDownloader = {
        let instance = ImageDownloader()
        // setup code
        return instance
    }()
}
