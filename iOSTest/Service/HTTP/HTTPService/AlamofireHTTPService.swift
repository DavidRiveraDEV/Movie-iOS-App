//
//  AlamofireHTTPService.swift
//  iOSTest
//
//  Created by David Rivera on 11/11/21.
//

import Foundation
import Alamofire

public class AlamofireHTTPService {
    
    private var logger: LoggerProtocol?
    
    init(with logger: LoggerProtocol? = BasicLogger(String(describing: AlamofireHTTPService.self))) {
        self.logger = logger
    }
    
    private func request(url: String, params: [String: Any]? = nil, headers: [String : String]? = nil, httpMethod: HTTPMethod, onSuccessful: @escaping (_ response: SuccessfulResponse) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void) {
        self.logger?.i("START ->", httpMethod.rawValue, url)
        self.logger?.i("PARAMS:", params ?? "No params")
        AF.request(url, method: self.getAlamofireHTTPMethod(from: httpMethod), parameters: params, headers: self.getHTTPHeaders(headers: headers)).response { response in
            self.process(response: response, onSuccessful: onSuccessful, onFailed: onFailed)
        }
    }
    
    private func request(url urlString: String, data: Data?, headers: [String : String]? = nil, httpMethod: HTTPMethod, onSuccessful: @escaping (_ response: SuccessfulResponse) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void) {
        self.logger?.i("START ->", httpMethod.rawValue, urlString)
        if let data = data {
            self.logger?.i("DATA:", String(decoding: data, as: UTF8.self))
        }
        guard let url = URL(string: urlString) else {
            self.logger?.e("ERROR:", StatusCode.badRequest, AlamofireHTTPService.malformedUrl)
            self.logger?.i("END ->", urlString)
            onFailed(FailedResponse(statusCode: .badRequest, description: AlamofireHTTPService.malformedUrl))
            return
        }
        AF.request(self.getURLRequest(url: url, data: data, headers: headers, method: self.getAlamofireHTTPMethod(from: httpMethod))).response { response in
            self.process(response: response, onSuccessful: onSuccessful, onFailed: onFailed)
        }
    }
    
    private func getHTTPHeaders(headers: [String : String]?) -> HTTPHeaders? {
        var httpHeaders: HTTPHeaders?
        if let headers = headers {
            httpHeaders = HTTPHeaders()
            for (name, value) in headers {
                httpHeaders?.add(name: name, value: value)
            }
        }
        return httpHeaders
    }
    
    private func getURLRequest(url: URL, data: Data?, headers: [String : String]? = nil, method: Alamofire.HTTPMethod) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpBody = data
        urlRequest.httpMethod = method.rawValue
        if let httpHeaders = self.getHTTPHeaders(headers: headers) {
            urlRequest.headers = httpHeaders
        }
        return urlRequest
    }
    
    private func process(response: AFDataResponse<Data?>, onSuccessful: (_ response: SuccessfulResponse) -> Void, onFailed: (_ response: FailedResponse) -> Void) {
        switch response.result {
        case .failure(let error):
            self.logger?.e("ERROR:", response.response?.statusCode ?? String.empty, error)
            self.logger?.i("END ->", response.response?.url ?? String.empty)
            onFailed(FailedResponse(statusCode: StatusCode.from(response.response?.statusCode) ?? .internalServerError, description: error.localizedDescription))
        case .success(let data):
            self.logger?.i("RESPONSE:", response.response?.statusCode ?? String.empty, data != nil ? String(decoding: data!, as: UTF8.self) : "No data")
            self.logger?.i("END ->", response.response?.url ?? String.empty)
            if let statusCode = StatusCode.from(response.response?.statusCode), statusCode.responseType != .success {
                var description: String?
                if let data = data {
                    description = String(decoding: data, as: UTF8.self)
                }
                onFailed(FailedResponse(statusCode: statusCode, description: description))
                return
            }
            onSuccessful(SuccessfulResponse(statusCode: StatusCode.from(response.response?.statusCode) ?? .ok, data: data))
        }
    }
    
    private func getAlamofireHTTPMethod(from httpMethod: HTTPMethod) -> Alamofire.HTTPMethod {
        switch httpMethod {
        case .post:
            return .post
        case .put:
            return .put
        case .delete:
            return .delete
        default:
            return .get
        }
    }
}

// MARK: - HTTPClientServiceProtocol

extension AlamofireHTTPService: HTTPServiceProtocol {
    
    public func get(url: String, params: [String: Any]? = nil, headers: [String : String]? = nil, onSuccessful: @escaping (_ response: SuccessfulResponse) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void) {
        request(url: url, params: params, headers: headers, httpMethod: .get, onSuccessful: onSuccessful, onFailed: onFailed)
    }
    
    public func post(url: String, data: Data?, headers: [String : String]? = nil, onSuccessful: @escaping (_ response: SuccessfulResponse) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void) {
        request(url: url, data: data, headers: headers, httpMethod: .post, onSuccessful: onSuccessful, onFailed: onFailed)
    }
    
    public func put(url: String, data: Data?, headers: [String : String]? = nil, onSuccessful: @escaping (_ response: SuccessfulResponse) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void) {
        request(url: url, data: data, headers: headers, httpMethod: .put, onSuccessful: onSuccessful, onFailed: onFailed)
    }
    
    public func delete(url: String, params: [String: Any]? = nil, headers: [String : String]? = nil, onSuccessful: @escaping (_ response: SuccessfulResponse) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void) {
        request(url: url, params: params, headers: headers, httpMethod: .delete, onSuccessful: onSuccessful, onFailed: onFailed)
    }
}

// MARK: - Constant strings

extension AlamofireHTTPService {
    static let serverError = "Server Could not be reached."
    static let malformedUrl = "Malformed url."
}
