//
//  MenuItemView.swift
//  NBC-W6-Kiosk
//
//  Created by Neoself on 11/27/24.
//
import UIKit

class MenuItemCell: UITableViewCell {
    static let identifier = "MenuItemCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let soldOutImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "SoldOut")
            imageView.isHidden = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray2
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let englishNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
        containerView.addSubview(itemImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(englishNameLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(soldOutImageView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            itemImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            itemImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            itemImageView.widthAnchor.constraint(equalToConstant: 80),
            itemImageView.heightAnchor.constraint(equalToConstant: 80),
            
            soldOutImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            soldOutImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            soldOutImageView.widthAnchor.constraint(equalToConstant: 89),
            soldOutImageView.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 16),
            
            englishNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            englishNameLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: englishNameLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
        ])
    }
    
    func configure(with item: Product) {
        nameLabel.text = item.name
        englishNameLabel.text = item.englishName
        priceLabel.text = "\(item.price)원"
        itemImageView.image = UIImage(named: item.thumbnailImageString)
        
        if item.stock == 0 {
            soldOutImageView.isHidden = false
            isUserInteractionEnabled = false
            itemImageView.alpha = 0.4
            nameLabel.alpha = 0.4
            englishNameLabel.alpha = 0.4
            priceLabel.alpha = 0.4
        } else {
            soldOutImageView.isHidden = true
            isUserInteractionEnabled = true
            itemImageView.alpha = 1.0
            nameLabel.alpha = 1.0
            englishNameLabel.alpha =  1.0
            priceLabel.alpha = 1.0
        }
    }
}
