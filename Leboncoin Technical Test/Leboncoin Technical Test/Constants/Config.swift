//
//  Config.swift
//  Leboncoin Technical Test
//
//  Created by Valentin Denis on 20/09/2021.
//

import Foundation

enum Environment {
    case dev, rec, prod
}

class Config: NSObject {
    
    static var environment: Environment {
        guard
            let env = Bundle.main.infoDictionary!["Environment"] as? String else {
                fatalError("Must declare Environment String in Info.plist")
        }
        switch env {
        case "DEV":
            return .dev
        case "REC":
            return .rec
        case "PROD":
            return .prod
        default:
            return .dev
        }
    }
    
}
