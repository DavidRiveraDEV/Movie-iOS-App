//
//  HTTPClientProtocol.swift
//  iOSTest
//
//  Created by David Rivera on 11/11/21.
//

import Foundation

public protocol HTTPClientProtocol {
    
    var baseUrl: String { get }
    var httpService: HTTPServiceProtocol { get }
    
    init(baseUrl: String, httpService: HTTPServiceProtocol)
    
    func get<T: Codable>(apiPath: String, pathParams: [String: Any]?, queryParams: [String: Any]?, headers: [String : String]?, onSuccessful: @escaping (_ response: T) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void)
    
    func get<T: Codable>(apiPath: String, pathParams: [String: Any]?, queryParams: [String: Any]?, headers: [String : String]?, onSuccessful: @escaping (_ response: [T]) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void)
    
    func post<T: Codable>(apiPath: String, pathParams: [String: Any]?, data: Data?, headers: [String : String]?, onSuccessful: @escaping (_ response: T) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void)
    
    func put<T: Codable>(apiPath: String, pathParams: [String: Any]?, data: Data?, headers: [String : String]?, onSuccessful: @escaping (_ response: T) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void)
    
    func delete<T: Codable>(apiPath: String, pathParams: [String: Any]?, queryParams: [String: Any]?, headers: [String : String]?, onSuccessful: @escaping (_ response: T) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void)
    
}
