//
//  Logger.swift
//  Leboncoin Technical Test
//
//  Created by Valentin Denis on 20/09/2021.
//

import Foundation

enum LogLevel: String {
    case none = "   "
    case info = "ℹ️ "
    case warning = "⚠️ "
    case error = "⛔️ "
    case request = "➡️ "
    case response = "⬅️ "
}

struct Logger {
    
    /// Logs to the console the message according to its level, only on DEV environment
    /// - Parameters:
    ///   - message: The message to log
    ///   - logLevel: The level of the log
    static func log(message: String, logLevel: LogLevel) {
        if Config.environment == .dev {
            let fullMessage = logLevel.rawValue.appending(message).replacingOccurrences(of: "\n", with: "\n   ")
            print(fullMessage)
        }
    }
}
