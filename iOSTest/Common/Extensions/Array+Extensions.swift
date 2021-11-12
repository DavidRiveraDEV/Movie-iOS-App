//
//  Array+Extensions.swift
//  iOSTest
//
//  Created by David Rivera on 11/11/21.
//

import Foundation

extension Array {
    
    var toPrint: String  {
        var str = ""
        for element in self {
            str += "\(element) "
        }
        return str
    }
}
