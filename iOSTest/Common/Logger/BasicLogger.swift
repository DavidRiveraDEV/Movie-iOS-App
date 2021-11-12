//
//  BasicLogger.swift
//  iOSTest
//
//  Created by David Rivera on 11/11/21.
//

import Foundation

public class BasicLogger: LoggerProtocol {
    
    private var tag: String?
    private let showingTrace: Bool
    
    init(showingTrace: Bool = false) {
        self.showingTrace = showingTrace
    }
    
    init(_ tag: String, showingTrace: Bool = false) {
        self.showingTrace = showingTrace
        self.tag = " - " + tag
    }
    
    public func v(_ messages: Any...) {
        print(self.getMessage(prefix: LogPrefix.verbose, messages: messages))
    }
    
    public func d(_ messages: Any...) {
        print(self.getMessage(prefix: LogPrefix.debug, messages: messages))
    }
    
    public func i(_ messages: Any...) {
        print(self.getMessage(prefix: LogPrefix.info, messages: messages))
    }
    
    public func w(_ messages: Any...) {
        print(self.getMessage(prefix: LogPrefix.warning, messages: messages))
    }
    
    public func e(_ messages: Any...) {
        print(self.getMessage(prefix: LogPrefix.error, messages: messages))
    }
    
    private func getMessage(prefix: String, messages: [Any]) -> String {
        return self.getDate() + " " + prefix + (self.tag ?? "") + ": " +
        messages.toPrint + "\n\(self.getTrace(file: #file, function: #function, line: #line))"
    }
    
    private func getTrace(file: String, function: String, line: Int) -> String {
        if (self.showingTrace) {
            return "\tat \(file.split(separator: "/").last ?? "") -> \(function):\(line)\n"
        }
        return .empty
    }
    
    private func getDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd H:m:ss.SSSS"
        return formatter.string(from: Date())
    }
    
    struct LogPrefix {
        static let verbose = "⚪ VERBOSE"
        static let debug = "🟢 DEBUG"
        static let info = "🔵 INFO"
        static let warning = "🟠 WARNING"
        static let error = "🔴 ERROR"
    }
}
