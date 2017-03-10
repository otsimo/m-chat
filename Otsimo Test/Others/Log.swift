//
//  Log.swift
//  OtsimoSDK
//
//  Created by Sercan Değirmenci on 25/01/16.
//  Copyright © 2016 Otsimo. All rights reserved.
//

import Foundation

public enum LogLevel: Int {
    case debug = 1
    case info = 2
    case warning = 3
    case error = 4
    case severe = 5
}

open class Log {
    static var logLevel: LogLevel = LogLevel.info
    open static func setLevel(_ level: LogLevel) {
        logLevel = level
    }
    
    open static func debug(_ message: String) {
        log(.debug, message: message)
    }
    
    open static func info(_ message: String) {
        log(.info, message: message)
    }
    
    open static func warm(_ message: String) {
        log(.warning, message: message)
    }
    
    open static func error(_ message: String) {
        log(.error, message: message)
    }
    
    open static func severe(_ message: String) {
        log(.severe, message: message)
    }
    
    fileprivate static func log(_ level: LogLevel, message: String) {
        if level.rawValue >= logLevel.rawValue {
            NSLog("[\(level)] \(message)")
        }
    }
}
