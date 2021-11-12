//
//  HTTPMethod.swift
//  iOSTest
//
//  Created by David Rivera on 11/11/21.
//

import Foundation

public struct HTTPMethod: RawRepresentable, Equatable, Hashable {
    
    public static let delete = HTTPMethod(rawValue: "DELETE")
    public static let get = HTTPMethod(rawValue: "GET")
    public static let post = HTTPMethod(rawValue: "POST")
    public static let put = HTTPMethod(rawValue: "PUT")
    
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}
