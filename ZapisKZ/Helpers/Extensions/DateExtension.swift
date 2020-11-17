//
//  DateExtension.swift
//  ZapisKZ
//
//  Created by Sultan on 11/17/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation

extension Date {
    
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }
    
    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }
    
    var weekdayName: String {
        let formatter = DateFormatter()
        let localeID = Locale.preferredLanguages.first
        formatter.locale = Locale(identifier: localeID!)
        formatter.dateFormat = "E"
        return formatter.string(from: self as Date)
    }
    
    func getFormattedDate(format: String) -> String {
        let dateFormatter = DateFormatter()
        let localeID = Locale.preferredLanguages.first
        dateFormatter.locale = Locale(identifier: localeID!)
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func getDayOfWeek(_ date: Date) -> Int {
        return Calendar.current.dateComponents([.weekday], from: self).weekday!
    }
    
    func getWeekDays(date: Date) -> [Date] {
        let startDate = date.startOfWeek
        let endDate = date.endOfWeek
        return Date.dates(from: startDate!, to: endDate!)
    }
    
    func compareDate(date1:Date, date2:Date) -> Bool {
        let order = Calendar.current.compare(date1, to: date2, toGranularity: .day)
        switch order {
        case .orderedSame:
            return true
        default:
            return false
        }
    }
    
    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        
        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
}
