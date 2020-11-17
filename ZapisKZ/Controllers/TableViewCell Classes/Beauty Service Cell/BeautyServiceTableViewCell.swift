//
//  BeautyServiceTableViewCell.swift
//  ZapisKZ
//
//  Created by Sultan on 11/17/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class BeautyServiceTableViewCell: UITableViewCell, ConfigurableCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var beautyServiceNameLabel:             UILabelDeviceClass!
    @IBOutlet weak var beautyServiceDurationLabel:         UILabelDeviceClass!
    @IBOutlet weak var beautyServicePriceLabel:            UILabelDeviceClass!
    @IBOutlet weak var beautyServicePrepaymentAmountLabel: UILabelDeviceClass!
    
    //MARK: - Reuse Identifier
    static var reuseID: String = "BeautyServiceTableViewCell"
    
    //MARK: - IndexPath
    private var indexPath: IndexPath?
    
    //MARK: - ViewModel
    weak var viewModel: BeautyServiceTableViewCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            indexPath = viewModel.indexPath
            
            beautyServiceNameLabel.text = viewModel.beautyServiceName
            beautyServiceDurationLabel.text = viewModel.beautyServiceDuration
            beautyServicePriceLabel.text = viewModel.beautyServicePrice
            
            if let prepayment = viewModel.beautyServicePrepaymentAmount {
                beautyServicePrepaymentAmountLabel.isHidden = false
                beautyServicePrepaymentAmountLabel.text = prepayment
            } else {
                beautyServicePrepaymentAmountLabel.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func serviceSelectionButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
}

extension BeautyServiceTableViewCell {
    
    func setupUI() {
        self.selectionStyle = .none
        
        beautyServicePrepaymentAmountLabel.backgroundColor = #colorLiteral(red: 1, green: 0.9760599732, blue: 0.7844812274, alpha: 1)
        beautyServicePrepaymentAmountLabel.textInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
        beautyServicePrepaymentAmountLabel.layer.masksToBounds = true
        beautyServicePrepaymentAmountLabel.layer.cornerRadius = 4
    }
}
