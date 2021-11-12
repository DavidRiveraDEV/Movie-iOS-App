//
//  ResponseProtocol.swift
//  iOSTest
//
//  Created by David Rivera on 11/11/21.
//

import Foundation

public protocol Response {
    var statusCode: StatusCode { get }
}
