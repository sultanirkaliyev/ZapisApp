//
//  CustomServiceSelectionButton.swift
//  ZapisKZ
//
//  Created by Sultan on 11/17/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class CustomServiceSelectionButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    override var isSelected: Bool {
        didSet {
            if oldValue != isSelected {
                setupSelectionState()
            }
        }
    }
    
    func setupButton() {
        layer.cornerRadius = 4
        self.setImage(UIImage(named: "add_icon"), for: .normal)
        self.setImage(UIImage(named: "checked_icon"), for: .selected)
        setupSelectionState()
    }
    
    func setupSelectionState() {
        
        if isSelected {
            backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            layer.borderWidth = 0
        } else {
            backgroundColor = .white
            layer.borderWidth = 1
            layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
    }
}
