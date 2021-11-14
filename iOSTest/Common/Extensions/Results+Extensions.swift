//
//  Results+Extensions.swift
//  iOSTest
//
//  Created by David Rivera on 14/11/21.
//

import Foundation
import RealmSwift

extension Results {
    
    func toArray<T>() -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}
