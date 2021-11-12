//
//  FailedResponse.swift
//  iOSTest
//
//  Created by David Rivera on 11/11/21.
//

import Foundation

public struct FailedResponse: Response {
    
    public let statusCode: StatusCode
    public let description: String?
    public let details: [String : Any]?
    
    init(statusCode: StatusCode, description: String?, details: [String : Any]? = nil) {
        self.statusCode = statusCode
        self.description = description
        self.details = details
    }
}
