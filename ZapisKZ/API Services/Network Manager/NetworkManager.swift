//
//  NetworkManager.swift
//  ZapisKZ
//
//  Created by Sultan on 11/16/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation
import Moya

enum APIEnvironment {
    case staging
    case qa
    case production
    
    var baseURL: String {
        
        switch self {
        case .staging:    return "http://zp.khangroup.kz/rest/clients-app/v1"
        case .qa:         return "http://zp.khangroup.kz/rest/clients-app/v1"
        case .production: return "http://zp.khangroup.kz/rest/clients-app/v1"
        }
    }
}

struct NetworkManager {
    static let environment: String = APIEnvironment.production.baseURL
}
