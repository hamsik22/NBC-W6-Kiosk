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
    let noOrderText = UILabel()
    // 주문내역을 표시하는 테이블 뷰
    let orderList = UITableView()
    // 주문수량, 주문금액을 표시하는 뷰
    private let totalOrderText = UIStackView() // horizontal
    var cartCount = 0
    var totalPrice = 0
    
    func setupOrderListView() {
        noOrderText.text = "메뉴를 선택해 주세요"
        noOrderText.textAlignment = .center
        
        setupTotalOrderText()
        
        [orderList, totalOrderText, noOrderText]
            .forEach{ addSubview($0) }
        
        noOrderText.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        orderList.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        totalOrderText.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
    }
    
    private func setupTotalOrderText() {
        
        let amountLabel = UILabel()
        amountLabel.text = "\(cartCount)개/20개"
        amountLabel.font = Fonts.sumCountFont()
        amountLabel.textAlignment = .right
        amountLabel.asColor(targetString: "\(cartCount)", color: .blue)

        let priceLabel = UILabel()
        priceLabel.text = "\(totalPrice)원"
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
    private func updateCartLabel(itemCount: Int, totalPrice: Int) {
        let text = "\(itemCount)개/20개 \(formatPrice(totalPrice))원"
        
        // NSMutableAttributedString으로 텍스트 생성
        let attributedText = NSMutableAttributedString(string: text)
        
        // "X개" 부분의 범위 찾기
        if let itemCountText = text.range(of: "\(itemCount)") {
            let nsRange = NSRange(itemCountText, in: text)
            attributedText.addAttribute(.foregroundColor, value: getItemCountColor(itemCount), range: nsRange)
            attributedText.addAttribute(.font, value: Fonts.sumCountFont(), range: nsRange) // itemCount 폰트
        }
        
        // 색상 설정: "0개", "1~19개", "20개"
        func getItemCountColor(_ itemCount: Int) -> UIColor {
            switch itemCount {
            case 0: return .black
            case 1...19: return .blue
            case 20: return .red
            default: return .black
            }
        }
        
        func formatPrice(_ price: Int) -> String {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter.string(from: NSNumber(value: price)) ?? "\(price)"
        }
    }
}

extension UILabel {
    func asColor(targetString: String, color: UIColor) {
            let fullText = text ?? ""
            let attributedString = NSMutableAttributedString(string: fullText)
            let range = (fullText as NSString).range(of: targetString)
            attributedString.addAttribute(.foregroundColor, value: color, range: range)
            attributedText = attributedString
        }
}
