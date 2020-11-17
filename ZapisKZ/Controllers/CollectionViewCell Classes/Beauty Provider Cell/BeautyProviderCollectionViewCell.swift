//
//  BeautyProviderCollectionViewCell.swift
//  ZapisKZ
//
//  Created by Sultan on 11/16/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit
import SDWebImage
import Cosmos

class BeautyProviderCollectionViewCell: UICollectionViewCell, ConfigurableCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var containerView:                             UIView!
    @IBOutlet weak var beautyProviderImageView:                   UIImageView!
    @IBOutlet weak var beautyProviderCashbackLabel:               UILabelDeviceClass!
    @IBOutlet weak var beautyProviderTypeLabel:                   UILabelDeviceClass!
    @IBOutlet weak var beautyProviderNameLabel:                   UILabelDeviceClass!
    @IBOutlet weak var beautyProviderAddressLabel:                UILabelDeviceClass!
    @IBOutlet weak var beautyProviderTodayReservationsCountLabel: UILabelDeviceClass!
    @IBOutlet weak var beautyProviderAverageRatingLabel:          UILabelDeviceClass!
    @IBOutlet weak var beautyProviderReservationDataStackView:    UIStackView!
    @IBOutlet weak var beautyProviderRatingDataStackView:         UIStackView!
    @IBOutlet weak var beautyProviderCheckRatingView:             CosmosView!
    
    var beautyProviderAvatarImageView: CircledImageView = {
        var avatarImageView = CircledImageView(frame: .zero)
        return avatarImageView
    }()
    
    //MARK: - Reuse Identifier
    static var reuseID: String = "BeautyProviderCollectionViewCell"
    
    //MARK: - IndexPath
    private var indexPath: IndexPath?
    
    //MARK: - ViewModel
    var viewModel: BeautyProviderCollectionViewCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            indexPath = viewModel.indexPath
            
            if let beautyProviderImage = viewModel.beautyProviderImage, let url = URL(string: beautyProviderImage) {
                beautyProviderImageView.setIndicatorStyle(.medium)
                beautyProviderImageView.setShowActivityIndicator(true)
                beautyProviderImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "image_not_found_placeholder"))
            } else {
                beautyProviderImageView.image = UIImage(named: "image_not_found_placeholder")
            }
            
            if let beautyProviderAvatarImage = viewModel.beautyProviderAvatarImage, let url = URL(string: beautyProviderAvatarImage), viewModel.sectionType == .master {
                beautyProviderAvatarImageView.isHidden = false
                beautyProviderAvatarImageView.setIndicatorStyle(.medium)
                beautyProviderAvatarImageView.setShowActivityIndicator(true)
                beautyProviderAvatarImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "avatar_not_found_placeholder"))
            } else {
                beautyProviderAvatarImageView.isHidden = true
            }
            
            if let cashback = viewModel.beautyProviderCashback {
                beautyProviderCashbackLabel.isHidden = false
                beautyProviderCashbackLabel.text = cashback
            } else {
                beautyProviderCashbackLabel.isHidden = true
            }
            
            beautyProviderTypeLabel.text = viewModel.beautyProviderType
            beautyProviderNameLabel.text = viewModel.beautyProviderName
            beautyProviderAddressLabel.text = viewModel.beautyProviderAddress
            
            if let reservationCount = viewModel.beautyProviderTodayReservationsCount {
                beautyProviderReservationDataStackView.isHidden = false
                beautyProviderTodayReservationsCountLabel.text = reservationCount
            }
            
            if let rating = viewModel.beautyProviderAverageRating {
                beautyProviderRatingDataStackView.isHidden = false
                beautyProviderAverageRatingLabel.text = rating
            }
            
            beautyProviderCheckRatingView.rating = viewModel.beautyProviderCheckRating
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        beautyProviderRatingDataStackView.isHidden = true
        beautyProviderReservationDataStackView.isHidden = true
    }    
}

extension BeautyProviderCollectionViewCell {
    
    func setupUI() {
        beautyProviderRatingDataStackView.isHidden = true
        beautyProviderReservationDataStackView.isHidden = true
        
        containerView.clipsToBounds = true
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10
        contentView.setCustomShadow(color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.1), opacity: 1, offset: CGSize(width: 0, height: 3), radius: 10)
        layer.masksToBounds = false
        
        beautyProviderCashbackLabel.textInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        beautyProviderCashbackLabel.textColor = .white
        beautyProviderCashbackLabel.layer.masksToBounds = true
        beautyProviderCashbackLabel.layer.cornerRadius = 4
        beautyProviderCashbackLabel.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        
        self.addSubview(beautyProviderAvatarImageView)
        beautyProviderAvatarImageView.snp.makeConstraints { (make) in
            make.center.equalTo(beautyProviderImageView.snp.center)
            make.width.height.equalTo(beautyProviderImageView.bounds.height/2)
        }
    }
}
