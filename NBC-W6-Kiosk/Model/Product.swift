//
//  Product.swift
//  NBC-W6-Kiosk
//
//  Created by 전성규 on 11/26/24.
//

import Foundation

struct Product {
    private let name: String
    private let price: Int
    private let thumbnailImageString: String
    private var stock: Int
    private var selectedCount: Int
    
    init(name: String, price: Int, thumbnailImageString: String, stock: Int, selectedCount: Int = 0) {
        self.name = name
        self.price = price
        self.thumbnailImageString = thumbnailImageString
        self.stock = stock
        self.selectedCount = selectedCount
    }
}
