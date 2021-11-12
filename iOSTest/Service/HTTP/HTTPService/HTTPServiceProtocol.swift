//
//  HTTPServiceProtocol.swift
//  iOSTest
//
//  Created by David Rivera on 11/11/21.
//

import Foundation

public protocol HTTPServiceProtocol {
    
    func get(url: String, params: [String: Any]?, headers: [String : String]?, onSuccessful: @escaping (_ response: SuccessfulResponse) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void)
    
    func post(url: String, data: Data?, headers: [String : String]?, onSuccessful: @escaping (_ response: SuccessfulResponse) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void)
    
    func put(url: String, data: Data?, headers: [String : String]?, onSuccessful: @escaping (_ response: SuccessfulResponse) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void)
    
    func delete(url: String, params: [String: Any]?, headers: [String : String]?, onSuccessful: @escaping (_ response: SuccessfulResponse) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void)
    
}
