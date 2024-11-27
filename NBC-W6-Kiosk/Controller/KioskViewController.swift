//
//  ViewController.swift
//  NBC-W6-Kiosk
//
//  Created by 황석현 on 11/25/24.
//

import UIKit
import SwiftUI

class KioskViewController: UIViewController, Observer {
    var menu: Menu!
    var shoppingBasket: ShoppingBasket!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menu = DefaultMenu()
        menu.addObserver(self)
        menu.notifySelectedMenu(.coffee)
        
        shoppingBasket = DefaultShoppingBasket()
        shoppingBasket.addObserver(self)
    }
    
    // TODO: MenuTableViewCell 을 Tap 했을때 해당 cell에 담김 데이터를 상품 구조체로 생성해 shoppingBasket 모델에 넘겨주면 됩니다.
    /* 예시 코드
     cell 눌렀을 때 함수나 델리게이트 {
        let product = DefaultProduct(category: .coffee, name: "아이스 아메리카노", englishName: "Ice Americano", price: 5000, thumbnailImageString: "image01.png", stock: 19)
        
        shoppingBasket.addProduct(product) <- 위 코드를 반드시 작성해 주셔야합니다.
     */
    
    func fetchMenu(_ filteredList: [DefaultProduct]) {
        print(filteredList)
    }
    
    func fetchShoppingBasket(_ list: [DefaultProduct]) {
        // MARK: menuTableViewCell을 탭하면 shoppingBasket 모델에서 해당 상품을 등록하고 리스트를 전달인자로 넘겨줍니다.
        // TODO: 장바구니에 보여질 상품 데이터들을 list 전달인자를 기반으로 구현하면 됩니다.
    }
}

struct KioskViewController_Preview: PreviewProvider {
    static var previews: some View {
        KioskViewController_Presentable()
    }
    // 메뉴 화면에 대한 로직
    struct KioskViewController_Presentable: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            KioskViewController()
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
}
