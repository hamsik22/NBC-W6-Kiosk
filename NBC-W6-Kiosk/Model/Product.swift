//
//  Product.swift
//  NBC-W6-Kiosk
//
//  Created by 전성규 on 11/26/24.
//

import Foundation

struct Product: Decodable {
    let id: String
    let category: MenuCategory
    let name: String
    let englishName: String
    let price: Int
    let thumbnailImageString: String
    var stock: Int
    var selectedCount: Int
    
    enum CodingKeys: CodingKey {
        case category
        case name
        case englishName
        case price
        case thumbnailImageString
        case stock
        case selectedCount
    }
    
    //TODO: JSON 데이터면 구조체 생성, 별도의 구조체에 id, selectedCount
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID().uuidString // Decodable로 인스턴스 생성시 UUID 할당
        self.category = try container.decode(MenuCategory.self, forKey: .category)
        self.name = try container.decode(String.self, forKey: .name)
        self.englishName = try container.decode(String.self, forKey: .englishName)
        self.price = try container.decode(Int.self, forKey: .price)
        self.thumbnailImageString = try container.decode(String.self, forKey: .thumbnailImageString)
        self.stock = try container.decode(Int.self, forKey: .stock)
        self.selectedCount = 0  // Decodable로 인스턴스 생성시 초기값 할당
    }
}
