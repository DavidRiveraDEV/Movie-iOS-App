//
//  HTTPClient.swift
//  iOSTest
//
//  Created by David Rivera on 11/11/21.
//

import Foundation

public class HTTPClient: HTTPClientProtocol {
    
    public var baseUrl: String
    
    public var httpService: HTTPServiceProtocol
    
    public required init(baseUrl: String, httpService: HTTPServiceProtocol) {
        self.baseUrl = baseUrl
        self.httpService = httpService
    }
    
    public func get<T>(apiPath: String, pathParams: [String : Any]? = nil, queryParams: [String : Any]? = nil, headers: [String : String]? = nil, onSuccessful: @escaping (T) -> Void, onFailed: @escaping (FailedResponse) -> Void) where T : Decodable, T : Encodable {
        let apiPathString = replaceParams(apiPath: apiPath, pathParams: pathParams)
        self.httpService.get(url: HTTPClientUtil.normalizeBaseUrl(self.baseUrl) + apiPathString, params: queryParams, headers: headers, onSuccessful: { response in
            self.processSuccesfulResponse(response, onSuccessful: onSuccessful, onFailed: onFailed)
        }, onFailed: { response in
            onFailed(response)
        })
    }
    
    public func get<T>(apiPath: String, pathParams: [String : Any]? = nil, queryParams: [String : Any]? = nil, headers: [String : String]? = nil, onSuccessful: @escaping ([T]) -> Void, onFailed: @escaping (FailedResponse) -> Void) where T : Decodable, T : Encodable {
        let apiPathString = replaceParams(apiPath: apiPath, pathParams: pathParams)
        self.httpService.get(url: HTTPClientUtil.normalizeBaseUrl(self.baseUrl) + apiPathString, params: queryParams, headers: headers, onSuccessful: { response in
            self.processSuccesfulResponse(response, onSuccessful: onSuccessful, onFailed: onFailed)
        }, onFailed: { response in
            onFailed(response)
        })
    }
    
    public func post<T>(apiPath: String, pathParams: [String : Any]? = nil, data: Data?, headers: [String : String]? = nil, onSuccessful: @escaping (T) -> Void, onFailed: @escaping (FailedResponse) -> Void) where T : Decodable, T : Encodable {
        let apiPathString = replaceParams(apiPath: apiPath, pathParams: pathParams)
        self.httpService.post(url: HTTPClientUtil.normalizeBaseUrl(self.baseUrl) + apiPathString, data: data, headers: headers, onSuccessful: { response in
            self.processSuccesfulResponse(response, onSuccessful: onSuccessful, onFailed: onFailed)
        }, onFailed: { response in
            onFailed(response)
        })
    }
    
    public func put<T>(apiPath: String, pathParams: [String : Any]? = nil, data: Data?, headers: [String : String]? = nil, onSuccessful: @escaping (T) -> Void, onFailed: @escaping (FailedResponse) -> Void) where T : Decodable, T : Encodable {
        let apiPathString = replaceParams(apiPath: apiPath, pathParams: pathParams)
        self.httpService.put(url: HTTPClientUtil.normalizeBaseUrl(self.baseUrl) + apiPathString, data: data, headers: headers, onSuccessful: { response in
            self.processSuccesfulResponse(response, onSuccessful: onSuccessful, onFailed: onFailed)
        }, onFailed: { response in
            onFailed(response)
        })
    }
    
    public func delete<T>(apiPath: String, pathParams: [String : Any]? = nil, queryParams: [String : Any]? = nil, headers: [String : String]? = nil, onSuccessful: @escaping (T) -> Void, onFailed: @escaping (FailedResponse) -> Void) where T : Decodable, T : Encodable {
        let apiPathString = replaceParams(apiPath: apiPath, pathParams: pathParams)
        self.httpService.delete(url: HTTPClientUtil.normalizeBaseUrl(self.baseUrl) + apiPathString, params: queryParams, headers: headers, onSuccessful: { response in
            self.processSuccesfulResponse(response, onSuccessful: onSuccessful, onFailed: onFailed)
        }, onFailed: { response in
            onFailed(response)
        })
    }
    
    private func processSuccesfulResponse<T: Codable>(_ response: SuccessfulResponse, onSuccessful: @escaping (_ response: T) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void) {
        if let data = response.data {
            do {
                let decoded: T = try data.decode(to: T.self)
                onSuccessful(decoded)
            } catch let error {
                processError(error, response: response, onFailed: onFailed)
            }
        } else {
            onFailed(FailedResponse(statusCode: StatusCode.noResponse, description: "Empty response"))
        }
    }
    
    private func processSuccesfulResponse<T: Codable>(_ response: SuccessfulResponse, onSuccessful: @escaping (_ response: [T]) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void) {
        if let data = response.data {
            do {
                let decoded: [T] = try data.decode(to: [T].self)
                onSuccessful(decoded)
            } catch let error {
                processError(error, response: response, onFailed: onFailed)
            }
        } else {
            onFailed(FailedResponse(statusCode: StatusCode.noResponse, description: "Empty response"))
        }
    }
    
    private func processError(_ error: Error, response: SuccessfulResponse, onFailed: @escaping (_ response: FailedResponse) -> Void) {
        var details: [String : Any]?
        if let data = response.data {
            let responseString = String(decoding: data, as: UTF8.self)
            details = ["response" : responseString]
        }
        onFailed(FailedResponse(statusCode: StatusCode.unprocessableEntity, description: error.localizedDescription, details: details))
    }
    
    private func replaceParams(apiPath: String, pathParams: [String : Any]?) -> String {
        var apiPathString = HTTPClientUtil.normalizePath(apiPath)
        if let pathParams = pathParams, !pathParams.isEmpty {
            for key in pathParams.keys {
                if let value = pathParams[key] {
                    apiPathString = apiPathString.replacingOccurrences(of: "{\(key)}", with: String(describing: value))
                }
            }
        }
        return apiPathString
    }
    
}
