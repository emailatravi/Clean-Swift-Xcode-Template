//
//  ErrorHelper.swift
//  AirtelAssigment
//
//  Created by Ravi Prakash Sahu on 04/01/20.
//  Copyright © 2020 Ravi Prakash Sahu. All rights reserved.
//

import Foundation

let requestInProgressError: NSError = {
    return NSError(domain: "com.cp.auth", code: -5999, userInfo: [NSLocalizedDescriptionKey : "Request in progress"])
}()

let oopsError: NSError = {
    return NSError(domain: "com.cp.auth", code: -5998, userInfo: [NSLocalizedDescriptionKey : "Oops, something went wrong. Please try after sometime."])
}()

let badURLError: NSError = {
    return NSError(domain: "com.cp.auth", code: -5997, userInfo: [NSLocalizedDescriptionKey : "Bad URL"])
}()

let noDataError: NSError = {
    return NSError(domain: "com.cp.auth", code: -5996, userInfo: [NSLocalizedDescriptionKey : "No data available"])
}()

func apiError(errorCode: Int) -> NSError {
    return NSError(domain: "com.cp.auth", code: errorCode, userInfo: [NSLocalizedDescriptionKey : "Server error. Please try after sometime."])
}
