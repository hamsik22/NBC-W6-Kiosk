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
        return view
    }()
    
    private let soldOutImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "SoldOut")
            imageView.isHidden = true
            return imageView
        }()
    
    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray2
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.nameFont()
        
        return label
    }()
    
    private let englishNameLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.englishNameFont()
        label.textColor = .gray2
        
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.priceFont()
        
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
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
        }
        
        itemImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        soldOutImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.size.equalTo(CGSize(width: 89, height: 38))
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalTo(itemImageView.snp.trailing).offset(16)
        }
        
        englishNameLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.equalTo(nameLabel)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(englishNameLabel.snp.bottom).offset(8)
            make.leading.equalTo(nameLabel)
        }
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
