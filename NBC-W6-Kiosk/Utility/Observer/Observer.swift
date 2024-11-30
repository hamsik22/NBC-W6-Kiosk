//
//  Observer.swift
//  NBC-W6-Kiosk
//
//  Created by 전성규 on 11/26/24.
//

import Foundation

protocol Observer {
    /// Menu.notifySelectedMenu 함수 내에서 호출
    /// - Parameter list: 필터링된 List를 전달인자로 받음
    ///
    /// Controller에서 전달인자를 기반으로 메뉴 TableView Data Reload
    func fetchMenu(_ filteredList: [Product])
}
