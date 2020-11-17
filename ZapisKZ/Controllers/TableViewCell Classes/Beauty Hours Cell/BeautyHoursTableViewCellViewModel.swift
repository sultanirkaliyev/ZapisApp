//
//  BeautyHoursTableViewCellViewModel.swift
//  ZapisKZ
//
//  Created by Sultan on 11/17/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation

class BeautyHoursTableViewCellViewModel {
    
    var workHours: String? {
        return String.combine(strings: [workStartTime.convertStringToDate()?.getFormattedDate(format: "HH:mm"), workEndTime.convertStringToDate()?.getFormattedDate(format: "HH:mm")], separator: " - ")
    }
    
    var workStartTime: String
    var workEndTime: String
    var indexPath: IndexPath
    var date: Date
    
    init(workStartTime: String, workEndTime: String, date: Date, indexPath: IndexPath) {
        self.workStartTime = workStartTime
        self.workEndTime = workEndTime
        self.date = date
        self.indexPath = indexPath
    }
}
