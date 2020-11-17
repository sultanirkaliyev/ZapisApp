//
//  BeautyMaster.swift
//  ZapisKZ
//
//  Created by Sultan on 11/16/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation

struct BeautyMaster: Codable {
    let id: Int?
    let name: String?
    let surname: String?
    let profession: String?
    let avatarURL: String?
    let rating: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case surname
        case profession
        case avatarURL = "avatarUrl"
        case rating
    }
}
