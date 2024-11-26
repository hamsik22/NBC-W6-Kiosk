//
//  Menu.swift
//  NBC-W6-Kiosk
//
//  Created by 전성규 on 11/26/24.
//

import Foundation

struct Menu {
    private let list: [Category] = [
        Category(
            type: .coffee,
            list: [
                Product(name: "아이스 아메리카노", price: 5000, thumbnailImageString: "image01.png", stock: 10),
                Product(name: "아이스 아메리카노", price: 5000, thumbnailImageString: "image01.png", stock: 0),
                Product(name: "아이스 아메리카노", price: 5000, thumbnailImageString: "image01.png", stock: 10),
                Product(name: "아이스 아메리카노", price: 5000, thumbnailImageString: "image01.png", stock: 10)
            ]),
        Category(
            type: .desert,
            list: [
                Product(name: "치즈 케이크", price: 7000, thumbnailImageString: "image02.png", stock: 99),
                Product(name: "치즈 케이크", price: 7000, thumbnailImageString: "image02.png", stock: 99),
                Product(name: "치즈 케이크", price: 7000, thumbnailImageString: "image02.png", stock: 99),
                Product(name: "치즈 케이크", price: 7000, thumbnailImageString: "image02.png", stock: 0)
            ]),
        Category(
            type: .ade,
            list: [
                Product(name: "레몬 에이드", price: 6000, thumbnailImageString: "image03.png", stock: 9),
                Product(name: "레몬 에이드", price: 6000, thumbnailImageString: "image03.png", stock: 9),
                Product(name: "레몬 에이드", price: 6000, thumbnailImageString: "image03.png", stock: 0),
                Product(name: "레몬 에이드", price: 6000, thumbnailImageString: "image03.png", stock: 9)
            ]),
        Category(
            type: .product,
            list: [
                Product(name: "텀블러", price: 20000, thumbnailImageString: "image04.png", stock: 0),
                Product(name: "텀블러", price: 20000, thumbnailImageString: "image04.png", stock: 0),
                Product(name: "텀블러", price: 20000, thumbnailImageString: "image04.png", stock: 0),
                Product(name: "텀블러", price: 20000, thumbnailImageString: "image04.png", stock: 4)
            ])
    ]
}
