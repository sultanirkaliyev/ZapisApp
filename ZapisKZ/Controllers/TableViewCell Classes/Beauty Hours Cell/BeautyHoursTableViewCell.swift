//
//  BeautyHoursTableViewCell.swift
//  ZapisKZ
//
//  Created by Sultan on 11/17/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class BeautyHoursTableViewCell: UITableViewCell, ConfigurableCell {

    //MARK: - IBOutlets
    @IBOutlet weak var weekDayLabel: UILabelDeviceClass!
    @IBOutlet weak var workStartEndTimeLabel: UILabelDeviceClass!
    
    //MARK: - Reuse Identifier
    static var reuseID: String = "BeautyHoursTableViewCell"
    
    //MARK: - IndexPath
    private var indexPath: IndexPath?
    
    //MARK: - ViewModel
    weak var viewModel: BeautyHoursTableViewCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            indexPath = viewModel.indexPath
            
            workStartEndTimeLabel.text = viewModel.workHours
            let weekDay = Date().getDayOfWeek(Date())
            setupWeekDayLabel(weekDay: weekDay, date: viewModel.date, indexPath: viewModel.indexPath)
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

extension BeautyHoursTableViewCell {
    
    func setupUI() {
        self.selectionStyle = .none
    }
    
    func setupWeekDayLabel(weekDay: Int, date: Date, indexPath: IndexPath) {
        
        weekDayLabel.text = date.weekdayName.uppercased()        
        weekDayLabel.textInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        weekDayLabel.layer.masksToBounds = true
        weekDayLabel.layer.cornerRadius = 4
        
        switch indexPath.row {
        case 0...4:
            weekDayLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            weekDayLabel.backgroundColor = #colorLiteral(red: 0.963286221, green: 0.9563224912, blue: 0.9686177373, alpha: 1)
        case 5, 6:
            weekDayLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            weekDayLabel.backgroundColor = #colorLiteral(red: 0.8324260116, green: 0.8370896578, blue: 0.8485921621, alpha: 1)
        default: break
        }
        
        if Date().compareDate(date1: date, date2: Date()) {
            weekDayLabel.textColor = .white
            weekDayLabel.backgroundColor = #colorLiteral(red: 0.6780049801, green: 0.520206511, blue: 1, alpha: 1)
        }        
    }
}
