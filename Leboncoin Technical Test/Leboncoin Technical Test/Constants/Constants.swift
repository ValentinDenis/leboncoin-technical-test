//
//  Constants.swift
//  Leboncoin Technical Test
//
//  Created by Valentin Denis on 20/09/2021.
//

import Foundation
import UIKit

struct Constants {
    
    struct Format {
        static var dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        static var currency = Locale.current.currencySymbol ?? "€"
    }
    
    struct API {
        static var baseUrl = "https://raw.githubusercontent.com/leboncoin/paperclip/master/"
    }
    
    struct Identifiers {
        struct Cells {
            static var adCollectionViewCellID = "adCollectionViewCellID"
            static var categoryTableViewCellID = "categoryTableViewCellID"
        }
    }
    
    struct Colors {
        static var orangeLBC = UIColor(named: "orangeLBC")
        static var blueLBC = UIColor(named: "blueLBC")
        static var blackLBC = UIColor(named: "blackLBC")
    }
    
    struct Font {
        enum OpenSans: String {
            case regular = "OpenSans-Regular"
            case light = "OpenSans-Light"
            case lightItalic = "OpenSans-LightItalic"
            case semiBold = "OpenSans-SemiBold"
            case semiBoldItalic = "OpenSans-SemiBoldItalic"
            case bold = "OpenSans-Bold"
            case boldItalic = "OpenSans-BoldItalic"
            case extraBold = "OpenSans-ExtraBold"
            case italic = "OpenSans-Italic"
            
            func font(withSize size: CGFloat = 14.0) -> UIFont {
                return UIFont(name: self.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
            }
        }
    }
}
