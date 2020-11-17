//
//  ServerResponseBeautySalonsList.swift
//  ZapisKZ
//
//  Created by Sultan on 11/16/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation

struct ServerResponseMainPage: Codable {
    let message: String?
    let data: ServerResponseBeautySalonsListData?
}

struct ServerResponseBeautySalonsListData: Codable {
    let recommendedFirms: [BeautyProvider]?
    let popularFirms: [BeautyProvider]?
    let recentlyAddedFirms: [BeautyProvider]?
    let masters: [BeautyProvider]?
    let isCategoriesHidden: Bool?
    let cities: [City]?
    let wrongServicePricePhones: [String]?
}

