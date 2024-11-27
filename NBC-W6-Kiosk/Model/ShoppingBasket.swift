//
//  ShoppingBasket.swift
//  NBC-W6-Kiosk
//
//  Created by 전성규 on 11/26/24.
//

import Foundation

protocol ShoppingBasket: Subject {
    mutating func addProduct(_ product: DefaultProduct)
}

struct DefaultShoppingBasket: ShoppingBasket {
    private var observers: [Observer] = []
    
    var list: [DefaultProduct] = []
    
    mutating func addObserver(_ observer: any Observer) { observers.append(observer) }
    
    mutating func addProduct(_ product: DefaultProduct) {
        list.append(product)
        
        observers.forEach { $0.fetchShoppingBasket(list) }
    }
}
