//
//  Subject.swift
//  NBC-W6-Kiosk
//
//  Created by 전성규 on 11/26/24.
//

import Foundation

protocol Subject {
    mutating func addObserver(_ observer: Observer)
    /// Controller에서 Sugmenut의 값이 변경될 때 호출
    /// - Parameter category: 변경된 Category를 전달받아 menu.list 프로퍼티를 필터링
    func notifySelectedMenu(_ category: MenuCategory)
    
    
    /// 결제버튼을 탭했을 때 호출
    /// - Parameter items: shoppingBasket에 담긴 Product
    /// - Parameter currentMenu: 현재 화면에 보여지고 이는 MenuCategory
    ///
    /// items 배열을 순회하면서 Menu.list 같은 id에 해당하는 Product를 찾아 selectedCount만큼 stroct 감소
    /// Model.list 데이터 변경 후 notifySelectedMenu(_:) 매개변수에 currentMenu를 담아 호출
    mutating func notifyOrder(_ items: [Product], _ currentMenu: MenuCategory)
}
