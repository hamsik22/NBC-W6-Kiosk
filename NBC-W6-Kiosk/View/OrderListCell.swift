//
//  OrderListCell.swift
//  NBC-W6-Kiosk
//
//  Created by 황석현 on 11/28/24.
//

import UIKit

class OrderListCell: UITableViewCell {
    static let identifier: String = "OrderListCell"
    
    private var productId: String?
    weak var delegate: OrderListCellDelegate?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.bascketNameFont()
        
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.bascketPriceFont()
        label.textColor = .gray2
        
        return label
    }()
    
    private let quantityControl: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.layer.borderWidth = 1
        stack.layer.borderColor = UIColor.separator.cgColor
        stack.layer.cornerRadius = 4
        
        return stack
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Fonts.bascketPriceFont()
        
        return label
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        selectionStyle = .none
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(quantityControl)
        
        [minusButton, quantityLabel, plusButton].forEach {
            quantityControl.addArrangedSubview($0)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
        }
        
        quantityControl.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(80)
            $0.height.equalTo(28)
        }
    }
    
    func configure(cartItem: CartItem, delegate: OrderListCellDelegate) {
        self.productId = cartItem.product.id
        self.delegate = delegate
        
        nameLabel.text = cartItem.product.name
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let priceString = formatter.string(from: NSNumber(value: cartItem.product.price)) ?? "\(cartItem.product.price)"
        priceLabel.text = "\(priceString)원"
        
        quantityLabel.text = "\(cartItem.quantity)"
        
        // 수량이 1일 때 쓰레기통 아이콘으로 변경
        if cartItem.quantity == 1 {
            minusButton.setImage(UIImage(systemName: "trash"), for: .normal)
            minusButton.setTitle(nil, for: .normal)
        } else {
            minusButton.setImage(nil, for: .normal)
            minusButton.setTitle("-", for: .normal)
            minusButton.setTitleColor(.label, for: .normal)
        }
    }
    
    @objc private func plusButtonTapped() {
        guard let productId = productId else { return }
        delegate?.increaseQuantity(for: productId)
    }
    
    @objc private func minusButtonTapped() {
        guard let productId = productId else { return }
        if quantityLabel.text == "1" {
            delegate?.removeItem(productId:productId)
        } else {
            delegate?.decreaseQuantity(for: productId)
        }
    }
}

