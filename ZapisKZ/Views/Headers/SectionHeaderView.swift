//
//  SectionHeaderView.swift
//  ZapisKZ
//
//  Created by Sultan on 11/16/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class SectionHeaderView: UICollectionReusableView, ConfigurableCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var sectionTitleLabel: UILabelDeviceClass!
    @IBOutlet weak var sectionDescriptionLabel: UILabelDeviceClass!
    
    //MARK: - Reuse Identifier
    static var reuseID: String = "SectionHeaderView"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }    
}
