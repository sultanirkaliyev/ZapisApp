//
//  BeautyMasterTableViewCell.swift
//  ZapisKZ
//
//  Created by Sultan on 11/16/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class BeautyMasterTableViewCell: UITableViewCell, ConfigurableCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var beautyMasterAvatarImageView:    CircledImageView!
    @IBOutlet weak var beautyMasterFullNameLabel:      UILabelDeviceClass!
    @IBOutlet weak var beautyMasterProfessionLabel:    UILabelDeviceClass!
    @IBOutlet weak var beautyMasterAverageRatingLabel: UILabelDeviceClass!
    
    //MARK: - Reuse Identifier
    static var reuseID: String = "BeautyMasterTableViewCell"
    
    //MARK: - IndexPath
    private var indexPath: IndexPath?
    
    //MARK: - ViewModel
    weak var viewModel: BeautyMasterTableViewCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            indexPath = viewModel.indexPath
            
            if let beautyMasterAvatarImage = viewModel.beautyMasterAvatarImage, let url = URL(string: beautyMasterAvatarImage) {
                beautyMasterAvatarImageView.setIndicatorStyle(.medium)
                beautyMasterAvatarImageView.setShowActivityIndicator(true)
                beautyMasterAvatarImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "avatar_not_found_placeholder"))
            } else {
                beautyMasterAvatarImageView.image = UIImage(named: "avatar_not_found_placeholder")
            }
            
            beautyMasterFullNameLabel.text = viewModel.beautyMasterFullName
            beautyMasterProfessionLabel.text = viewModel.beautyMasterProfession
            beautyMasterAverageRatingLabel.text = viewModel.beautyMasterAverageRating
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension BeautyMasterTableViewCell {
    
    func setupUI() {
        self.selectionStyle = .none
    }
}
