//
//  BeautyService.swift
//  ZapisKZ
//
//  Created by Sultan on 11/16/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation

struct BeautyService: Codable {
    let id: Int?
    let subCategoryID: Int?
    let name: String?
    let price: Int?
    let duration: Int?
    let prepaymentAmount: Int?
    let priceStr: String?
    let durationStr: String?
    let categoryID: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case subCategoryID = "subCategoryId"
        case name
        case price
        case duration
        case prepaymentAmount
        case priceStr
        case durationStr
        case categoryID = "categoryId"
    }
}
