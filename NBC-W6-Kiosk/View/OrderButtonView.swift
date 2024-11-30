//
//  OrderButtonView.swift
//  NBC-W6-Kiosk
//
//  Created by 전성규 on 11/28/24.
//

import UIKit
import SnapKit

final class BottomOrderView: UIView {
    weak var delegate: BottomOrderViewDelegate?
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 12.0
        
        return stackView
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.gray9, for: .normal)
        button.titleLabel?.font = Fonts.submitButtonFont()
        
        button.backgroundColor = .gray0
        
        button.layer.cornerRadius = 12.0
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.separator.cgColor
        
        button.addTarget(self, action: #selector(cancelButtonDidTap), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var orderButton: UIButton = {
        let button = UIButton()
        button.setTitle("결제", for: .normal)
        button.titleLabel?.font = Fonts.submitButtonFont()
        
        button.backgroundColor = .blue0
        
        button.layer.cornerRadius = 12.0
        
        button.addTarget(self, action: #selector(orderButtonDidTap), for: .touchUpInside)
        
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        backgroundColor = .systemBackground
        addSubview(contentStackView)
        [cancelButton, orderButton].forEach { contentStackView.addArrangedSubview($0) }
    }
    
    private func setupConstraints() {
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16))
            $0.height.equalTo(48)
        }
    }
    
    @objc func cancelButtonDidTap() { self.delegate?.cancelButtonDidTap() }
    @objc func orderButtonDidTap() { self.delegate?.orderButtonDidTap() }
}

#if DEBUG

import SwiftUI

struct BottomOrderView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonOrderView_Presentable()
            .edgesIgnoringSafeArea(.all)
            .frame(
                width: UIScreen.main.bounds.width,
                height: 57.0,
                alignment: .center)
    }
    
    struct ButtonOrderView_Presentable: UIViewRepresentable {
        func makeUIView(context: Context) -> some UIView {
            BottomOrderView()
        }
        
        func updateUIView(_ uiView: UIViewType, context: Context) {}
    }
    
}

#endif
