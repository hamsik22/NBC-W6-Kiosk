//
//  Menu.swift
//  NBC-W6-Kiosk
//
//  Created by 전성규 on 11/26/24.
//

import Foundation

struct Menu: Subject {
    private var observers: [Observer] = []
    
    var list: [Product] = []
    
    mutating func addObserver(_ observer: any Observer) { observers.append(observer) }
    
    func notifySelectedMenu(_ category: MenuCategory) {
        let filteredList = list.filter { $0.category == category }
        observers.forEach { $0.fetchMenu(filteredList) }
    }
    
    mutating func notifyOrder(_ items: [Product], _ currentMenu: MenuCategory) {
        for i in 0...items.endIndex {
            for j in 0...list.endIndex {
                if list[j].id == items[i].id {
                    list[j].stock = list[j].stock - items[i].selectedCount
                    break
                }
            }
        }
        
        notifySelectedMenu(currentMenu)
    }
}

