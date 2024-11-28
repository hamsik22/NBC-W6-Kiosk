//
//  ViewController.swift
//  NBC-W6-Kiosk
//
//  Created by 황석현 on 11/25/24.
//  Updated by 김형석 on 11/27/24.

import UIKit

class KioskViewController: UIViewController, Observer {
    var menu: Menu!
    // 결제완료 후 현재 화면에 보여지고있는 메뉴 tableView를 reload하기 위해 선언
    var currentMenu: MenuCategory = .hot
    
    private var filteredMenuItems: [Product] = []
    private var shoppingBasketItems: [Product] = [] {
        didSet {
            print(shoppingBasketItems)
        }
    }
    
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
    
    private let orderList: OrderList = {
        let view = OrderList()
        view.backgroundColor = .blue
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu = Menu()
        // View가 그려지기 전에 json 데이터 디코팅 후 menu 모델에 저장
        menu.list = decode(from: fetchDataFromJSONFile()!) ?? []
        menu.addObserver(self)
        
        setupUI()
        setupTableView()
        menu.notifySelectedMenu(currentMenu)
    }
    
    private func setupUI() {
        view.backgroundColor = .gray0
        view.addSubview(segmentedControl) // 메뉴 카테고리
        view.addSubview(tableView) // 메뉴선택
        orderList.setupOrderListView()
        view.addSubview(orderList)
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        orderList.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-50)
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        orderList.orderList.delegate = self
        orderList.orderList.dataSource = self
        tableView.register(MenuItemCell.self, forCellReuseIdentifier: MenuItemCell.identifier)
        orderList.orderList.register(OrderListCell.self, forCellReuseIdentifier: OrderListCell.identifier)
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let selectedCategory = MenuCategory.allCases[sender.selectedSegmentIndex]
        
        menu.notifySelectedMenu(selectedCategory)
        currentMenu = selectedCategory
    }
    
    func fetchMenu(_ filteredList: [Product]) {
        filteredMenuItems = filteredList
        tableView.reloadData()
    }
}

extension KioskViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberofSec\(tableView)")
        if tableView == self.tableView {
            return filteredMenuItems.count
        } else {
            print(shoppingBasketItems.count)
            return shoppingBasketItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuItemCell.identifier, for: indexPath) as? MenuItemCell else { return UITableViewCell() }
            cell.configure(with: filteredMenuItems[indexPath.row])
            return cell
        } else if tableView == orderList.orderList {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderListCell.identifier, for: indexPath) as? OrderListCell else { return UITableViewCell() }
            cell.configure(with: shoppingBasketItems[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 메뉴 tableViewCell이 탭 됐을 때 tableView의 indexPath.row를 사용해 선택된 Product를 filteredMenuItems에서 찾아 shoppingBasketItems에 추가
        shoppingBasketItems.append(filteredMenuItems[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension KioskViewController {
    
    /// JSON 파일을 불러와 Data로 변환하는 함수
    /// - Returns: JSON Data
    private func fetchDataFromJSONFile() -> Data? {
        guard let path = Bundle.main.path(forResource: "MenuData", ofType: "json") else { return nil }
        guard let jsonString = try? String(contentsOfFile: path) else { return nil }
        
        return jsonString.data(using: .utf8)
    }
    
    
    /// JSON 파일 기반으로 변환된 데이터를 Product 구초체 형식으로 디코딩하는 함수
    /// - Parameter data: JSON 데이터
    /// - Returns: 구조체로 디코딩 된 Product 배열
    private func decode(from data: Data) -> [Product]? {
        guard let productList = try? JSONDecoder().decode([Product].self, from: data) else { return nil }
        
        return productList
    }
}


#if DEBUG

import SwiftUI

struct KioskViewController_Preview: PreviewProvider {
    static var previews: some View {
        KioskViewController_Presentable()
    }
    
    struct KioskViewController_Presentable: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            KioskViewController()
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
}

#endif
