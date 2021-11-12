//
//  Data+Extensions.swift
//  iOSTest
//
//  Created by David Rivera on 11/11/21.
//

import Foundation

extension Data {
    
    static func encode<T: Codable>(from object: T) throws -> Data {
        return try JSONEncoder().encode(object)
    }
    
    func decode<T: Codable>(to type: T.Type) throws -> T {
        return try JSONDecoder().decode(type, from: self)
    }
    
    func decode<T: Codable>(to type: [T].Type) throws -> [T] {
        return try JSONDecoder().decode(type, from: self)
    }

}
