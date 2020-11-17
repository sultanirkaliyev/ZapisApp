//
//  BeautyProviderCollectionViewCellViewModel.swift
//  ZapisKZ
//
//  Created by Sultan on 11/16/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation

class BeautyProviderCollectionViewCellViewModel {
    
    var beautyProviderImage: String? {
        if let image = beautyProvider.pictureURL {
            return NetworkManager.environment + image
        }
        return nil
    }
    
    var beautyProviderAvatarImage: String? {
        if let image = beautyProvider.avatarURL {
            return NetworkManager.environment + image
        }
        return nil
    }
    
    var beautyProviderCashback: String? {
        if let cashback = beautyProvider.prepaymentCashbackAmount {
            return "Кэшбек " + cashback
        }
        return nil
    }
    
    var beautyProviderType: String? {
        return beautyProvider.type
    }
    
    var beautyProviderName: String? {
        return beautyProvider.name
    }
    
    var beautyProviderAddress: String? {
        return beautyProvider.address
    }
    
    var beautyProviderTodayReservationsCount: String? {
        if let todayReservationsCount = beautyProvider.todayReservationsCount {
            return "1"
        }
        return "0"
    }
    
    var beautyProviderAverageRating: String? {
        if let averageRating = beautyProvider.averageRating {
            return "\(averageRating)"
        }
        return nil
    }
    
    var beautyProviderCheckRating: Double {
        if let checkRating = beautyProvider.checkRating {
            return Double(checkRating)
        }
        return 0.0
    }
    
    var beautyProvider: BeautyProvider
    var indexPath: IndexPath
    var sectionType: TypeOfBeautyProviderSection
    
    init(beautyProvider: BeautyProvider, indexPath: IndexPath, sectionType: TypeOfBeautyProviderSection) {
        self.beautyProvider = beautyProvider
        self.indexPath = indexPath
        self.sectionType = sectionType
    }
}
