//
//  OrderListCell.swift
//  NBC-W6-Kiosk
//
//  Created by 황석현 on 11/28/24.
//

import UIKit

class OrderListCell: UITableViewCell {
    
    static let identifier: String = "OrderListCell"
    
    //delegate
    weak var delegate: OrderListCellDelegate?

    // Product 데이터를 저장하기 위한 프로퍼티
    private var product: Product?
    
    let trashCanImage = UIImage(systemName: "trash")
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let cartMenu: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(hue: 0, saturation: 0, brightness: 0.45, alpha: 1.0)
        //TODO: 다크모드설정 label.textColor = UIColor(hue: 0, saturation: 0, brightness: 0.83, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countView: UIView = {
        let view = UIView()
        
        //테두리 설정
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(hue: 0, saturation: 0, brightness: 0.54, alpha: 1.0).cgColor
        view.layer.cornerRadius = 4
        //TODO: 다크모드설정 UIColor(hue: 0, saturation: 0, brightness: 0.89, alpha: 1.0)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    let selectLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(hue: 0, saturation: 0, brightness: 0.45, alpha: 1.0)
        //TODO: 다크모드설정 UIColor(hue: 0, saturation: 0, brightness: 0.54, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let plusButton: UIButton = {
        let button = UIButton()
        button.tag = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let minusButton: UIButton = {
        let button = UIButton()
        
        //이미지로 쓰레기통 hidden
        
        button.tag = 0
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
        //버튼 delegate 연결
        minusButton.addTarget(self, action: #selector(minusButtonDidTap), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusButtonDidTap), for: .touchUpInside)
    }
    
    //마이너스 버튼 delegate 연결
    @objc func minusButtonDidTap() {
        if let product = product { // product 값 전달
            delegate?.minusButtonDidTap(in: self, product: product)
        }
    }
    //플러스 버튼 delegate 연결
    @objc func plusButtonDidTap() {
        if let product = product { // product 값 전달
            delegate?.plusButtonDidTap(in: self, product: product)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    private func setupUI() {
        contentView.addSubview(containerView)
        
        cartMenu.addSubview(nameLabel)
        cartMenu.addSubview(priceLabel)
        containerView.addSubview(cartMenu)
        
        countView.addSubview(selectLabel)
        countView.addSubview(plusButton)
        countView.addSubview(minusButton)
        containerView.addSubview(countView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 24),
            
            cartMenu.widthAnchor.constraint(equalToConstant: 268),
            cartMenu.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            cartMenu.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 3),
            nameLabel.leadingAnchor.constraint(equalTo: cartMenu.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: cartMenu.trailingAnchor),
            
            selectLabel.centerXAnchor.constraint(equalTo: countView.centerXAnchor),
            selectLabel.centerYAnchor.constraint(equalTo: countView.centerYAnchor),
            selectLabel.topAnchor.constraint(equalTo: countView.topAnchor),
            plusButton.trailingAnchor.constraint(equalTo: countView.trailingAnchor),
            plusButton.centerYAnchor.constraint(equalTo: countView.centerYAnchor),
            plusButton.widthAnchor.constraint(equalToConstant: 24),
            minusButton.widthAnchor.constraint(equalToConstant: 24),
            minusButton.centerYAnchor.constraint(equalTo: countView.centerYAnchor),
            minusButton.leadingAnchor.constraint(equalTo: countView.leadingAnchor),
            countView.topAnchor.constraint(equalTo: containerView.topAnchor),
            countView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            countView.widthAnchor.constraint(equalToConstant: 70),
            countView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
     
    func configure(with item: Product) {
        product = item
        nameLabel.text = item.name
        
        priceLabel.text = "\(item.selectedCount * item.price)원"
        plusButton.setTitle("+", for: .normal)
        
        
        if item.selectedCount > 1 {
            minusButton.setTitle("-", for: .normal)
            minusButton.setImage(nil, for: .normal)
        } else {
            minusButton.setTitle(nil, for: .normal)
            minusButton.setImage(UIImage(systemName: "trash"), for: .normal)
        }
        
        selectLabel.text = "\(item.selectedCount)"
    }
    
}

//프로토콜
protocol OrderListCellDelegate: AnyObject {
    func minusButtonDidTap(in cell: OrderListCell, product: Product)
    func plusButtonDidTap(in cell: OrderListCell, product: Product)
}
