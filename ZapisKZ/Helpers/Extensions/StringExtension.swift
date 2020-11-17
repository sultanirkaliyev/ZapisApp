//
//  StringExtension.swift
//  ZapisKZ
//
//  Created by Sultan on 11/16/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation

extension String {
    
    static func combine(strings: [String?], separator: String) -> String {
        return strings.compactMap { $0 }.joined(separator: separator)
    }
    
    func convertStringToDate() -> Date? {
        
        let dateFormats = ["yyyy-MM-dd'T'HH:mm:ss",
                           "yyyy-MM-dd'T'HH:mm:ssZ",
                           "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
                           "yyyy-MM-dd hh:mm:ss",
                           "yyyy-MM-dd",
                           "MM-dd-yyyy",
                           "dd-MM-yyyy HH:mm"]
        
        let localeID = Locale.preferredLanguages.first
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: localeID!)
        
        for dateFormatValue in dateFormats {
            
            dateFormatter.dateFormat = dateFormatValue
            
            if let dateFromString = dateFormatter.date(from: self) {
                let newStringFromDate = dateFormatter.string(from: dateFromString)
                let convertedDate = dateFormatter.date(from: newStringFromDate)
                return convertedDate!
            }
        }
        return nil
    }
}
