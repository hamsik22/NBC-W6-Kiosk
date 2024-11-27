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
}
