//
//  CancellableDataTask.swift
//  TwitterClean
//
//  Created by Ravi Prakash Sahu on 21/01/20.
//  Copyright © 2020 Ravi Prakash Sahu. All rights reserved.
//

import Foundation

protocol CancellableDataTask: class {
    var serialQueue: DispatchQueue {get set}
    var dataTaskStore:[String: URLSessionTask] {get set}
    
    func addTask(hash: String, urlSessionTask: URLSessionTask)
    
    func cancelTask(hash: String)
    func cancelAllTask()
    
    func pauseTask(hash: String)
    func pauseAllTask()
    
    func resumeTask(hash: String)
    func resumeAllTask()
    
    func removeTask(hash: String)
    func removeAllTask()
    
    func isRequestExecuting(hash: String) -> Bool
}

extension CancellableDataTask {
    func addTask(hash: String, urlSessionTask: URLSessionTask) {
        serialQueue.async {
            self.dataTaskStore[hash] = urlSessionTask
        }
    }
    
    func cancelTask(hash: String) {
        serialQueue.async {
            if let dataTask = self.dataTaskStore[hash] {
                dataTask.cancel()
                // Remove task from dataTaskStore
                self.dataTaskStore.removeValue(forKey: hash)
            }
        }
    }
    
    func cancelAllTask() {
        serialQueue.async {
            self.dataTaskStore.forEach { _, task in
                task.cancel()
            }
            
            self.dataTaskStore.removeAll()
        }
    }
    
    func pauseTask(hash: String) {
        serialQueue.async {
            if let dataTask = self.dataTaskStore[hash] {
                dataTask.suspend()
            }
        }
    }
    
    func pauseAllTask() {
        serialQueue.async {
            //dataTaskStore.forEach{$1.cancel()}
            self.dataTaskStore.forEach { _, task in
                // Cancel the task
                task.suspend()
            }
        }
    }
    
    func resumeTask(hash: String) {
        serialQueue.async {
            if let dataTask = self.dataTaskStore[hash] {
                dataTask.resume()
            }
        }
    }
    
    func resumeAllTask() {
        serialQueue.async {
            //dataTaskStore.forEach{$1.cancel()}
            self.dataTaskStore.forEach { _, task in
                // Cancel the task
                task.resume()
            }
        }
    }
    
    func removeTask(hash: String) {
        serialQueue.async {
            if let _ = self.dataTaskStore[hash] {
                self.dataTaskStore.removeValue(forKey: hash)
            }
        }
    }
    func removeAllTask() {
        serialQueue.async {
            self.dataTaskStore.removeAll()
        }
    }
    
    func isRequestExecuting(hash: String) -> Bool {
        if let _ = dataTaskStore[hash] {
            return true
        }
        return false
    }
}
