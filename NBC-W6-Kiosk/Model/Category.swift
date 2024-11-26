//
//  Category.swift
//  NBC-W6-Kiosk
//
//  Created by 전성규 on 11/26/24.
//

import Foundation

enum CategoryType: String {
    case coffee
    case desert
    case ade
    case product
}

struct Category {
    private let type: CategoryType
    private var list: [Product]
    
    init(type: CategoryType, list: [Product]) {
        self.type = type
        self.list = list
    }
}
