//
//  OrderList.swift
//  NBC-W6-Kiosk
//
//  Created by 황석현 on 11/27/24.
//

import Foundation
import UIKit

class OrderListView: UIView {
    
    var itemList: [DefaultProduct] = []
    
    // 주문내역이 없을 시 표시되는 문구
    private let noOrderText = UILabel()
    // 주문내역을 표시하는 테이블 뷰
    private let orderList = UITableView()
    // 주문수량, 주문금액을 표시하는 뷰
    private let totalOrderText = UIStackView() // horizontal
    
    func setupOrderListView() {
        noOrderText.text = "메뉴를 선택해 주세요"
        noOrderText.textAlignment = .center
        noOrderText.translatesAutoresizingMaskIntoConstraints = false
        
        //TODO: cell 등록 필요
        orderList.delegate = self
        orderList.dataSource = self
        orderList.translatesAutoresizingMaskIntoConstraints = false
        
        setupTotalOrderText()
        
        [noOrderText, orderList, totalOrderText]
            .forEach{ addSubview($0) }
        
        // TODO: 레이아웃 설정
        NSLayoutConstraint.activate([
            // noOrderText의 위치
            noOrderText.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            noOrderText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            noOrderText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            // orderList의 위치
            orderList.topAnchor.constraint(equalTo: noOrderText.bottomAnchor, constant: 20),
            orderList.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            orderList.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            orderList.bottomAnchor.constraint(equalTo: totalOrderText.topAnchor, constant: -20),
            
            // totalOrderText의 위치
            totalOrderText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            totalOrderText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            totalOrderText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            totalOrderText.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    func setupTotalOrderText() {
        
        let amountLabel = UILabel()
        amountLabel.text = "총 0/20개"
        amountLabel.textAlignment = .right
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let priceLabel = UILabel()
        priceLabel.text = "0원"
        priceLabel.textAlignment = .right
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        totalOrderText.axis = .horizontal
        totalOrderText.distribution = .equalSpacing
        totalOrderText.alignment = .trailing
        totalOrderText.translatesAutoresizingMaskIntoConstraints = false
        
        [amountLabel, priceLabel]
            .forEach{ totalOrderText.addSubview($0) }
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
