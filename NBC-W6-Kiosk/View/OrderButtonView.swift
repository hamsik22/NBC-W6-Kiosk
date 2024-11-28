//
//  OrderButtonView.swift
//  NBC-W6-Kiosk
//
//  Created by 전성규 on 11/28/24.
//

import UIKit
import SnapKit

protocol OrderButtonViewDelegate: AnyObject {
    func cancelButtonDidTap()
    
    func orderButtonDidTap()
}

final class OrderButtonView: UIView {
    weak var delegate: OrderButtonViewDelegate?
    
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
        button.backgroundColor = .red   // TODO: 색상 변경
        button.layer.cornerRadius = 12.0
        button.addTarget(self, action: #selector(cancelButtonDidTap), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var orderButton: UIButton = {
        let button = UIButton()
        button.setTitle("결제", for: .normal)
        button.backgroundColor = .red   // TODO: 색상 변경
        button.layer.cornerRadius = 12.0
        button.addTarget(self, action: #selector(orderButtonDidTap), for: .touchUpInside)
        
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.configUI()
        self.setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        addSubview(contentStackView)
        [cancelButton, orderButton].forEach { contentStackView.addArrangedSubview($0) }
    }
    
    @objc func cancelButtonDidTap() {
        self.delegate?.cancelButtonDidTap()
    }
    
    @objc func orderButtonDidTap() { self.delegate?.orderButtonDidTap() }
    
    private func setupConstraints() {
        contentStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.bottom.equalToSuperview().inset(9.0)
        }
    }
}

#if DEBUG

import SwiftUI

struct OrderButtonView_Previews: PreviewProvider {
    static var previews: some View {
        OrderButtonView_Presentable()
            .edgesIgnoringSafeArea(.all)
            .frame(
                width: UIScreen.main.bounds.width,
                height: 57.0,
                alignment: .center)
    }
    
    struct OrderButtonView_Presentable: UIViewRepresentable {
        func makeUIView(context: Context) -> some UIView {
            OrderButtonView()
        }
        
        func updateUIView(_ uiView: UIViewType, context: Context) {}
    }
    
}

#endif
