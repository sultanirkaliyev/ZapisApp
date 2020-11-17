//
//  BeautySalonMapViewModel.swift
//  ZapisKZ
//
//  Created by Sultan on 11/17/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation

class BeautySalonMapViewModel {
    
    var beautyProviderLocation: BeautyProviderLocation
    
    init(beautyProviderLocation: BeautyProviderLocation) {
        self.beautyProviderLocation = beautyProviderLocation
    }
}

extension BeautySalonMapViewModel {
    
    func getLocation() -> (latitude: Double, longitude: Double)? {
        if let latitude = beautyProviderLocation.markerY, let longitude = beautyProviderLocation.markerX {
            return (latitude, longitude)
        }
        return nil
    }
}
