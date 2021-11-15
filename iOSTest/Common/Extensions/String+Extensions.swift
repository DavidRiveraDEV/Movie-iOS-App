//
//  String+Extensions.swift
//  iOSTest
//
//  Created by David Rivera on 11/11/21.
//

import Foundation

extension String {
    
    public static var empty: String {
        get {
            return ""
        }
    }
    
    static func removeNil(_ value : String?) -> String {
        return value ?? .empty
    }
    
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
