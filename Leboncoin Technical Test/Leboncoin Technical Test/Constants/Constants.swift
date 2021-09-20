//
//  Constants.swift
//  Leboncoin Technical Test
//
//  Created by Valentin Denis on 20/09/2021.
//

import Foundation

struct Constants {
    
    struct Format {
        static var dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        static var currency = Locale.current.currencySymbol ?? "€"
    }
    
    struct API {
        static var baseUrl = "https://raw.githubusercontent.com/leboncoin/paperclip/master/"
    }
    
}
