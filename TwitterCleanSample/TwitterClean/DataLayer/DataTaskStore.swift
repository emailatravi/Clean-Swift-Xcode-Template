//
//  DataTaskStore.swift
//  AirtelAssigment
//
//  Created by Ravi Prakash Sahu on 04/01/20.
//  Copyright © 2020 Ravi Prakash Sahu. All rights reserved.
//

import Foundation

class DataTaskStore: CancellableDataTask {
    var serialQueue: DispatchQueue
    
    var dataTaskStore: [String : URLSessionTask]
    
    init() {
        self.serialQueue = DispatchQueue(label: "com.itt.datataskstore")
        // Create data store cach
        self.dataTaskStore = [String : URLSessionTask]()
    }
}
