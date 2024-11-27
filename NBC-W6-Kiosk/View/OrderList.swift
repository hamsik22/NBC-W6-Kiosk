//
//  OrderList.swift
//  NBC-W6-Kiosk
//
//  Created by 황석현 on 11/27/24.
//

import Foundation
import UIKit

class OrderListView: UIView {
    
    var itemList: [MenuItem] = []

    // 주문내역이 없을 시 표시되는 문구
    let noOrderText = UILabel()
    // 주문내역을 표시하는 테이블 뷰
    let orderList = UITableView()
    // 주문수량, 주문금액을 표시하는 뷰
    let totalOrderText = UIStackView() // horizontal
    
    // 백그라운드 색 넣자
    func setupOrderListView() {
        
    }
}

class OrderList: UITableView {
    let orderList = UITableView()
    
    func setUpOrderList() {
        
    }
}

extension OrderListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if itemList.count == 0 { noOrderText.isHidden = false } else { noOrderText.isHidden = true }
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderListCell", for: indexPath)
        
        return cell
    }
}
