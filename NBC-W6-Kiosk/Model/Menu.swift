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
    func notifySelectedMenu(_ category: MenuCategory)
}

struct DefaultMenu: Menu {
    private var observers: [Observer] = []
    
    private let list: [DefaultProduct] = [
        DefaultProduct(category: .Hot, name: "아이스 아메리카노", englishName: "Ice Americano", price: 5000, thumbnailImageString: "image01.png", stock: 19),
        DefaultProduct(category: .Iced, name: "치즈 케이크", englishName: "Cheese Cake", price: 7000, thumbnailImageString: "image02.png", stock: 2),
        DefaultProduct(category: .Ade, name: "레몬에이드", englishName: "Lemone Ade", price: 6000, thumbnailImageString: "image03.png", stock: 40),
        DefaultProduct(category: .Dessert, name: "텀블러", englishName: "Tumbler", price: 20000, thumbnailImageString: "image04.png", stock: 0),
        DefaultProduct(category: .Hot, name: "에스프레소", englishName: "Espresso", price: 3700, thumbnailImageString: "image05.png", stock: 1),
        DefaultProduct(category: .Hot, name: "카페라떼", englishName: "Cafe Latte", price: 4500, thumbnailImageString: "image05.png", stock: 2),
        DefaultProduct(category: .Dessert, name: "티라미수", englishName: "Tiramisu", price: 6500, thumbnailImageString: "image05.png", stock: 2),
        DefaultProduct(category: .Dessert, name: "초코케이크", englishName: "Chocolate Cake", price: 6000, thumbnailImageString: "image05.png", stock: 2),
    ]
    
    mutating func addObserver(_ observer: any Observer) { observers.append(observer) }
    
    func notifySelectedMenu(_ category: MenuCategory) {
        let filteredList = list.filter { $0.category == category }
        observers.forEach { $0.fetchMenu(filteredList) }
    }
}

