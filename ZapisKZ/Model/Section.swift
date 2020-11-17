//
//  Section.swift
//  ZapisKZ
//
//  Created by Sultan on 11/16/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation

class Section: Hashable {
    
    var id = UUID()
    var sectionTitle: String
    var sectionDescription: String
    var items: [BeautyProvider]
    var sectionType: TypeOfBeautyProviderSection
    
    init(sectionTitle: String, sectionDescription: String, items: [BeautyProvider], sectionType: TypeOfBeautyProviderSection) {
        self.sectionTitle = sectionTitle
        self.sectionDescription = sectionDescription
        self.items = items
        self.sectionType = sectionType
    }
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
    
    static func == (lhs: Section, rhs: Section) -> Bool {
      lhs.id == rhs.id
    }
}
