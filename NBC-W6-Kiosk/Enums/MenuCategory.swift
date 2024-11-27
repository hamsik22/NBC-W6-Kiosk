import Foundation

enum MenuCategory: String, CaseIterable, Decodable {
    case hot = "Hot"
    case iced = "Iced"
    case ade = "Ade"
    case dessert = "Dessert"
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        
        switch rawValue {
        case "Hot": self = .hot
        case "Iced": self = .iced
        case "Ade": self = .ade
        case "Dessert": self = .dessert
        default: fatalError("Unknown case from container")
        }
    }
}
