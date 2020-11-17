//
//  BeautySalonListService.swift
//  ZapisKZ
//
//  Created by Sultan on 11/16/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation
import Moya

enum BeautySalonListService {
    case getMainPageInformation
    case getBeautyProviderInformation(beautyProviderID: Int)
}

extension BeautySalonListService: TargetType, AccessTokenAuthorizable {
    
    var baseURL: URL {
        guard let url = URL(string: NetworkManager.environment) else { fatalError("baseURL could not be configured") }
        return url
    }
    
    var path: String {
        switch self {
        case .getMainPageInformation: return "/screen/home"
        case .getBeautyProviderInformation(beautyProviderID: let beautyProviderID): return "/firms/\(beautyProviderID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMainPageInformation: return .get
        case .getBeautyProviderInformation(_): return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getMainPageInformation: return .requestPlain
        case .getBeautyProviderInformation(_): return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Accept": "application/json"]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
    var authorizationType: AuthorizationType {
        switch self {
        case .getMainPageInformation: return .bearer
        case .getBeautyProviderInformation(_): return .bearer
        }
    }
}

