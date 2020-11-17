//
//  AuthTokenService.swift
//  ZapisKZ
//
//  Created by Sultan on 11/16/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation

class AuthTokenService {
    private init() {}
    static let shared = AuthTokenService()
}

extension AuthTokenService {
    
    func getToken() -> String {
        return "none"
    }
}
