//
//  ServerResponseBeautyProviderDetail.swift
//  ZapisKZ
//
//  Created by Sultan on 11/16/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation

struct ServerResponseBeautyProviderDetail: Codable {
    let message: String?
    let data: ServerResponseBeautyProviderDetailData?
}

struct ServerResponseBeautyProviderDetailData: Codable {
    let firm: BeautyProvider?
    let masters: [BeautyMaster]?
    let services: [BeautyService]?
    let categories, subCategories: [BeautyServiceCategory]?
    let isOnline: Bool?
    let hasDiscounts: Bool?
    let location: BeautyProviderLocation?
}




