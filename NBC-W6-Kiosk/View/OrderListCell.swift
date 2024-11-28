//
//  OrderListCell.swift
//  NBC-W6-Kiosk
//
//  Created by 황석현 on 11/28/24.
//

import UIKit

class OrderListCell: UITableViewCell {
    
    static let identifier: String = "OrderListCell"
    
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
    
    private let priceLabel: UILabel = {
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
        
    private let selectLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(hue: 0, saturation: 0, brightness: 0.45, alpha: 1.0)
        //TODO: 다크모드설정 UIColor(hue: 0, saturation: 0, brightness: 0.54, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let minusButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
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
        nameLabel.text = item.name
        priceLabel.text = "\(item.price)원"
        plusButton.setTitle("+", for: .normal)
        minusButton.setTitle("-", for: .normal)//TODO: 개수 0일 경우 쓰레기통 표시로 변경
        selectLabel.text = "1" //TODO: 개수 동적으로 수정
    }
    
}
