//
//  Product.swift
//  NBC-W6-Kiosk
//
//  Created by 전성규 on 11/26/24.
//

import Foundation

protocol Product: Subject {
    /// selectedCount 프로퍼티 값이 변경됐을 때 Observer에 알리는 함수
    /// - Parameter selectedCount: Observer 함수의 매개변수로 전달
    func notify(selectedCount: Int)
}

struct DefaultProduct: Product {
    private var observers: [Observer] = []
    
    let category: MenuCategory
    let name: String
    let englishName: String
    let price: Int
    let thumbnailImageString: String
    
    /// if stock == 0 { sould out }
    var stock: Int
    private var selectedCount: Int {
        didSet { notify(selectedCount: selectedCount) }
    }
    
    init(category: MenuCategory, name: String, englishName: String, price: Int, thumbnailImageString: String, stock: Int, selectedCount: Int = 0) {
        self.category = category
        self.name = name
        self.englishName = englishName
        self.price = price
        self.thumbnailImageString = thumbnailImageString
        self.stock = stock
        self.selectedCount = selectedCount
    }
    
    mutating func addObserver(_ observer: any Observer) { observers.append(observer) }
    
    func notify(selectedCount: Int) {
        // TODO: 장바구니 화면 연동까지 확인 후 구연
    }
}
