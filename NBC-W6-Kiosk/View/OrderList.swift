//
//  OrderList.swift
//  NBC-W6-Kiosk
//
//  Created by 황석현 on 11/27/24.
//

import UIKit
import SnapKit

class OrderList: UIView {
    
    var itemList: [Product]?
    
    // 주문내역이 없을 시 표시되는 문구
    private let noOrderText = UILabel()
    // 주문내역을 표시하는 테이블 뷰
    let orderList = UITableView()
    // 주문수량, 주문금액을 표시하는 뷰
    private let totalOrderText = UIStackView() // horizontal
    
    func setupOrderListView() {
        noOrderText.text = "메뉴를 선택해 주세요"
        noOrderText.textAlignment = .center
        noOrderText.backgroundColor = .blue
        
        orderList.backgroundColor = .red

        
        setupTotalOrderText()
        totalOrderText.backgroundColor = .green
        
        [orderList, totalOrderText, noOrderText]
            .forEach{ addSubview($0) }
        
        noOrderText.snp.makeConstraints {
            $0.top.equalToSuperview()
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
    
    private func setupTotalOrderText() {
        
        let amountLabel = UILabel()
        amountLabel.text = "총 0/20개"
        amountLabel.font = Fonts.sumCountFont()
        amountLabel.textAlignment = .right
        
        let priceLabel = UILabel()
        priceLabel.text = "0원"
        priceLabel.font = Fonts.sumPrice()
        priceLabel.textAlignment = .right
        
        totalOrderText.axis = .horizontal
        
        [amountLabel, priceLabel]
            .forEach{ totalOrderText.addSubview($0) }
        
        priceLabel.snp.makeConstraints {
            $0.right.equalToSuperview().inset(30)
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

