//
//  ConfigurableCell.swift
//  ZapisKZ
//
//  Created by Sultan on 11/16/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation

protocol ConfigurableCell: class {
    static var reuseID: String { get }
}
