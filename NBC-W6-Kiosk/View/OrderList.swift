//
//  OrderList.swift
//  NBC-W6-Kiosk
//
//  Created by 황석현 on 11/27/24.
//

import UIKit
import SnapKit

class OrderList: UIView {
    let cart = Cart()
    weak var delegate: OrderListDelegate?
    
    let orderTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    private let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "메뉴를 선택해주세요"
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        
        label.font = Fonts.bascketNameFont()
        
        return label
    }()
    
    private let totalOrderView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        
        return view
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.remitCountFont()
        
        return label
    }()
    
    private let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.sumPrice()
        label.textAlignment = .right
        
        return label
    }()
    
    var cartCount: Int = 0 { didSet {
        updateCountLabel()
    } }
    
    var totalPrice: Int = 0 { didSet {
        updateTotalPriceLabel()
    } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .systemBackground
        
        addSubview(orderTableView)
        addSubview(emptyStateLabel)
        addSubview(totalOrderView)
        totalOrderView.addSubview(countLabel)
        totalOrderView.addSubview(totalPriceLabel)
        
        orderTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(totalOrderView.snp.top)
        }
        
        emptyStateLabel.snp.makeConstraints {
            $0.center.equalTo(orderTableView)
        }
        
        totalOrderView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        totalPriceLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(85) // 너비를 85로 설정
        }
        
        countLabel.snp.makeConstraints {
            $0.trailing.equalTo(totalPriceLabel.snp.leading).offset(-16)
            $0.centerY.equalToSuperview()
        }
        
        updateCountLabel()
        updateTotalPriceLabel()
    }
    
    private func setupTableView() {
        orderTableView.delegate = self
        orderTableView.dataSource = self
        orderTableView.register(OrderListCell.self, forCellReuseIdentifier: OrderListCell.identifier)
    }
    
    func addItem(_ product: Product) {
        if !cart.addItem(product) {
            delegate?.showMaxItemsAlert()
            return
        }
        updateUI()
    }
    
    func clearCart() {
        cart.clear()
        updateUI()
    }
    
    private func updateUI() {
        cartCount = cart.totalQuantity
        totalPrice = cart.totalPrice
        emptyStateLabel.isHidden = !cart.items.isEmpty
        orderTableView.reloadData()
    }
    
    private func updateCountLabel() {
        let text = "총 \(cartCount)개/20개"
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: "\(cartCount)")
        
        let color: UIColor = cartCount == 20 ? .systemRed : cartCount == 0  ? .gray9 : .blue0
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        
        let font = Fonts.sumCountFont()
        attributedString.addAttribute(.font, value: font, range: range)
        
        countLabel.attributedText = attributedString
    }
    
    private func updateTotalPriceLabel() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let priceString = formatter.string(from: NSNumber(value: totalPrice)) ?? "\(totalPrice)"
        totalPriceLabel.text = "\(priceString)원"
    }
}

extension OrderList: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderListCell.identifier, for: indexPath) as? OrderListCell else {
            return UITableViewCell()
        }
        
        let item = cart.items[indexPath.row]
        cell.configure(cartItem: item, delegate: self)
        
        // 첫 번째 셀 부분 상품리스트에 16여백주기
        if indexPath.row == 0 {
            cell.contentView.layoutMargins = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        } else {
            cell.contentView.layoutMargins = .zero
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}


extension OrderList: OrderListCellDelegate {
    func increaseQuantity(for productId: String) {
        guard let item = cart.items.first(where: { $0.product.id == productId }) else { return }
        
        if !cart.addItem(item.product) {
            delegate?.showMaxItemsAlert()
            return
        }
        updateUI()
    }
    
    func decreaseQuantity(for productId: String) {
        cart.decreaseQuantity(for: productId)
        updateUI()
    }
    
    func removeItem(productId: String) {
        cart.removeItem(productId: productId)
        updateUI()
    }
}
