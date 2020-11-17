//
//  BeautySalonListViewModel.swift
//  ZapisKZ
//
//  Created by Sultan on 11/16/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit
import PromiseKit

class BeautySalonListViewModel {
    
    //MARK: - Moya Provider
    var beautySalonListDataService: BeautySalonListDataService
    
    //MARK: - Data Binding Properties
    var networkRequestFailureReason: Box<NetworkRequestFailureReason?> = Box(nil)
    var mainPageData: Box<ServerResponseBeautySalonsListData?> = Box(nil)
    
    //MARK: - Properties
    var sections = [Section]()
    
    init(beautySalonListDataService: BeautySalonListDataService) {
        self.beautySalonListDataService = beautySalonListDataService
    }
    
    func prepareDataSourceSnapshot(data: ServerResponseBeautySalonsListData) -> NSDiffableDataSourceSnapshot<Section, BeautyProvider> {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, BeautyProvider>()
        sections.removeAll()
        
        if let recommendedFirms = data.recommendedFirms {
            sections.append(Section(sectionTitle: "Рекомендуем", sectionDescription: "Самые посещаемые салоны", items: recommendedFirms, sectionType: .salon))
        }
        
        if let popularFirms = data.popularFirms {
            sections.append(Section(sectionTitle: "Популярные", sectionDescription: "Популярные салоны", items: popularFirms, sectionType: .salon))
        }
        
        if let recentlyAddedFirms = data.recentlyAddedFirms {
            sections.append(Section(sectionTitle: "Недавно добавленные", sectionDescription: "Недавное добавленные салоны", items: recentlyAddedFirms, sectionType: .salon))
        }
        
        if let masters = data.masters {
            sections.append(Section(sectionTitle: "Индивидуальные мастера", sectionDescription: "Профессионалы в своем деле", items: masters, sectionType: .master))
        }
        
        snapshot.appendSections(sections)
        
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        
        return snapshot
    }
}

extension BeautySalonListViewModel {
    
    func fetchMainPageData() {
        
        firstly {
            beautySalonListDataService.getMainPageInformation()
        }.done { (result) in
            switch result {
            case .success(payload: let serverData): self.mainPageData.value = serverData
            default: break
            }
        }.catch { (error) in
            self.networkRequestFailureReason.value = error as? NetworkRequestFailureReason
        }
    }
}
