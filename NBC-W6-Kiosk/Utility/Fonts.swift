import UIKit

struct Fonts {
    // 카테고리바
    static func categoryFont() -> UIFont {
        return UIFont(name: "NotoSansKR-SemiBold", size: 13) ?? UIFont.systemFont(ofSize: 13)
    }
    
    // 상단 메뉴 바
    static func nameFont() -> UIFont {
        return UIFont(name: "NotoSansKR-Medium", size: 16) ?? UIFont.systemFont(ofSize: 16)
    }
    static func englishNameFont() -> UIFont {
        return UIFont(name: "NotoSansKR-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12)
    }
    
    static func priceFont() -> UIFont {
        return UIFont(name: "NotoSansKR-Medium", size: 16) ?? UIFont.systemFont(ofSize: 16)
    }
    
    // 장바구니 메뉴 바
    static func bascketNameFont() -> UIFont {
        return UIFont(name: "NotoSansKR-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)
    }
    
    static func bascketPriceFont() -> UIFont {
        return UIFont(name: "NotoSansKR-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)
    }
    
    // 하단 총개 금액
    static func sumCountFont() -> UIFont {
        return UIFont(name: "NotoSansKR-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16)
    }
    
    static func remitCountFont() -> UIFont {
        return UIFont(name: "NotoSansKR-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)
    }
    
    static func sumPrice() -> UIFont {
        return UIFont(name: "NotoSansKR-Bold", size: 20) ?? UIFont.systemFont(ofSize: 20)
    }
    
    // 결제 및 취소 버튼
    static func submitButtonFont() -> UIFont {
        return UIFont(name: "NotoSansKR-Bold", size: 17) ?? UIFont.systemFont(ofSize: 17)
    }
}
