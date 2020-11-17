//
//  BeautyMasterTableViewCellViewModel.swift
//  ZapisKZ
//
//  Created by Sultan on 11/16/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class BeautyMasterTableViewCellViewModel {
    
    var beautyMasterAvatarImage: String? {
        if let image = beautyMaster.avatarURL {
            return NetworkManager.environment + image
        }
        return nil
    }
    
    var beautyMasterFullName: String? {
        return String.combine(strings: [beautyMaster.name, beautyMaster.surname], separator: " ")
    }
    
    var beautyMasterProfession: String? {
        return beautyMaster.profession
    }
    
    var beautyMasterAverageRating: String {
        if let averageRating = beautyMaster.rating {
            return "\(averageRating)"
        }
        return "0.0"
    }
    
    var beautyMaster: BeautyMaster
    var indexPath: IndexPath
    
    init(beautyMaster: BeautyMaster, indexPath: IndexPath) {
        self.beautyMaster = beautyMaster
        self.indexPath = indexPath
    }
}
