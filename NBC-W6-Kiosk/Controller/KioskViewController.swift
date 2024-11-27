//
//  ViewController.swift
//  NBC-W6-Kiosk
//
//  Created by 황석현 on 11/25/24.
//  Updated by 김형석 on 11/27/24.
 
import UIKit
import SwiftUI

class KioskViewController: UIViewController, Observer {
    var menu: Menu!
    var shoppingBasket: ShoppingBasket!
    
    
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

    private let allMenuItems: [MenuItem] = [
        MenuItem(name: "에스프레소", englishName: "Espresso", price: 3700, category: .coffee),
        MenuItem(name: "아메리카노", englishName: "Americano", price: 4000, category: .coffee),
        MenuItem(name: "카페라떼", englishName: "Cafe Latte", price: 4500, category: .coffee),
        MenuItem(name: "티라미수", englishName: "Tiramisu", price: 6500, category: .dessert),
        MenuItem(name: "초코케이크", englishName: "Chocolate Cake", price: 6000, category: .dessert),
        MenuItem(name: "레몬에이드", englishName: "Lemon Ade", price: 5500, category: .ade),
        MenuItem(name: "텀블러", englishName: "Tumbler", price: 28000, category: .products)
    ]
    
    private var filteredMenuItems: [MenuItem] = []
    
    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: MenuCategory.allCases.map { $0.rawValue })
        control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu = DefaultMenu()
        menu.addObserver(self)
        menu.notifySelectedMenu(.coffee)
        
        shoppingBasket = DefaultShoppingBasket()
        shoppingBasket.addObserver(self)
        
        setupUI()
        setupTableView()
        filterMenuItems(for: .coffee)
    }
    
    private func setupUI() {
        view.backgroundColor = .gray0
        view.addSubview(segmentedControl)
        view.addSubview(tableView)
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MenuItemCell.self, forCellReuseIdentifier: MenuItemCell.identifier)
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let selectedCategory = MenuCategory.allCases[sender.selectedSegmentIndex]
        filterMenuItems(for: selectedCategory)
    }
    
    private func filterMenuItems(for category: MenuCategory) {
        filteredMenuItems = allMenuItems.filter { $0.category == category }
        tableView.reloadData()
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
extension KioskViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuItemCell.identifier, for: indexPath) as? MenuItemCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: filteredMenuItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
