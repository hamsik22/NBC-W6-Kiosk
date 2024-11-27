//
//  Menu.swift
//  NBC-W6-Kiosk
//
//  Created by 전성규 on 11/26/24.
//

import Foundation

protocol Menu: Subject {
    /// Controller에서 Sugmenut의 값이 변경될 때 호출
    /// - Parameter category: 변경된 Category를 전달받아 list 프로퍼티를 필터링
    func notifySelectedMenu(_ category: Category)
}

struct DefaultMenu: Menu {
    private var observers: [Observer] = []
    
    private let list: [DefaultProduct] = [
        DefaultProduct(category: .coffee, name: "아이스 아메리카노", englishName: "Ice Americano", price: 5000, thumbnailImageString: "image01.png", stock: 19),
        DefaultProduct(category: .desert, name: "치즈 케이크", englishName: "Cheese Cake", price: 7000, thumbnailImageString: "image02.png", stock: 2),
        DefaultProduct(category: .ade, name: "레몬에이드", englishName: "Lemone Ade", price: 6000, thumbnailImageString: "image03.png", stock: 40),
        DefaultProduct(category: .products, name: "텀블러", englishName: "Tumbler", price: 20000, thumbnailImageString: "image04.png", stock: 0)
    ]
    
    mutating func addObserver(_ observer: any Observer) { observers.append(observer) }
    
    func notifySelectedMenu(_ category: Category) {
        let filteredList = list.filter { $0.category == category }
        observers.forEach { $0.fetchMenu(filteredList) }
    }
}
