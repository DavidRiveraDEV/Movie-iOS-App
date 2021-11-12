//
//  HTTPHeader.swift
//  iOSTest
//
//  Created by David Rivera on 11/11/21.
//

import Foundation

public struct HTTPHeader: RawRepresentable, Equatable, Hashable {
    
    public static let authorization = HTTPHeader(rawValue: "Authorization")
    public static let contentType = HTTPHeader(rawValue: "Content-Type")
    public static let applicationJson = HTTPHeader(rawValue: "application/json")
    public static let multipartFormData = HTTPHeader(rawValue: "multipart/form-data")

    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}
