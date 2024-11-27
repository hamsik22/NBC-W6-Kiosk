//
//  OrderList.swift
//  NBC-W6-Kiosk
//
//  Created by 황석현 on 11/27/24.
//

import UIKit
import SnapKit

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
        
        noOrderText.snp.makeConstraints {
            $0.top.equalTo(20)
            $0.centerY.equalToSuperview()
            $0.width.equalToSuperview()
            
        }
        
        orderList.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.bottom.equalTo(20)
        }
        
        totalOrderText.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(20)
            $0.bottom.equalToSuperview()
        }
        
    }
    
    func setupTotalOrderText() {
        
        let amountLabel = UILabel()
        amountLabel.text = "총 0/20개"
        amountLabel.textAlignment = .right
        
        let priceLabel = UILabel()
        priceLabel.text = "0원"
        priceLabel.textAlignment = .right
        
        totalOrderText.axis = .horizontal
        totalOrderText.distribution = .equalSpacing
        totalOrderText.alignment = .trailing
        
        [amountLabel, priceLabel]
            .forEach{ totalOrderText.addSubview($0) }
        
        priceLabel.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalToSuperview()
        }
        
        amountLabel.snp.makeConstraints {
            $0.right.equalTo(priceLabel.snp.left)
            $0.width.equalTo(80)
            $0.height.equalToSuperview()
        }
        
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
