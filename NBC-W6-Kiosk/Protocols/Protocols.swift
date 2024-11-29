//
//  Protocols.swift
//  NBC-W6-Kiosk
//
//  Created by Neoself on 11/29/24.
//

protocol OrderListDelegate: AnyObject {
    func showMaxItemsAlert()
}

protocol BottomOrderViewDelegate: AnyObject {
    func cancelButtonDidTap()
    func orderButtonDidTap()
}

protocol OrderListCellDelegate: AnyObject {
    func increaseQuantity(for productId: String)
    func decreaseQuantity(for productId: String)
    func removeItem(productId: String)
}
