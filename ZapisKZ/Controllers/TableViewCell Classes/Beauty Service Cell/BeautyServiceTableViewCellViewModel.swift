//
//  BeautyServiceTableViewCellViewModel.swift
//  ZapisKZ
//
//  Created by Sultan on 11/17/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation

class BeautyServiceTableViewCellViewModel {
    
    var beautyServiceName: String? {
        return beautyService.name
    }
    
    var beautyServiceDuration: String? {
        return beautyService.durationStr
    }
    
    var beautyServicePrice: String? {
        return beautyService.priceStr
    }
    
    var beautyServicePrepaymentAmount: String? {
        if let prepayment = beautyService.prepaymentAmount {
            return "предоплата \(prepayment) ₸"
        }
        return nil
    }
    
    var beautyService: BeautyService
    var indexPath: IndexPath
    
    init(beautyService: BeautyService, indexPath: IndexPath) {
        self.beautyService = beautyService
        self.indexPath = indexPath
    }
}
