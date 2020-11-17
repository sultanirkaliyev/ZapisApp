//
//  BeautyProviderImageCollectionViewCellViewModel.swift
//  ZapisKZ
//
//  Created by Sultan on 11/17/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation

class BeautyProviderImageCollectionViewCellViewModel {
        
    var preparedImage: String {
        return NetworkManager.environment + image
    }
    
    var image: String
    var indexPath: IndexPath
    
    init(image: String, indexPath: IndexPath) {
        self.image = image
        self.indexPath = indexPath
    }
}
