//
//  BeautyProvider.swift
//  ZapisKZ
//
//  Created by Sultan on 11/16/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation

struct BeautyProvider: Codable, Hashable {
    let id: Int?
    let name: String?
    let address: String?
    let type: String?
    let checkRating: Int?
    let urlKey: String?
    let isPromoted: Bool?
    let avatarURL: String?
    let isIndividualMaster: Bool?
    let workSchedule: String?
    let pictureURL: String?
    let averageRating: Double?
    let todayReservationsCount: String?
    let pictures: [String]?
    let isFavorite: Bool?
    let prepaymentCashbackAmount: String?
    let category: String?
    let workStartTime: String?
    let workEndTime: String?
    let state: String?
    let instagramProfile: String?
    let cityName: String?
    let phoneNumbers: [String]?
    let isMastersHidden: Bool?
    let reviewCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case address
        case type
        case checkRating
        case urlKey
        case isPromoted
        case avatarURL = "avatarUrl"
        case isIndividualMaster
        case workSchedule
        case pictureURL = "pictureUrl"
        case averageRating
        case todayReservationsCount
        case pictures
        case isFavorite
        case prepaymentCashbackAmount
        case category
        case workStartTime
        case workEndTime
        case state
        case instagramProfile
        case cityName
        case phoneNumbers
        case isMastersHidden
        case reviewCount
    }
}
