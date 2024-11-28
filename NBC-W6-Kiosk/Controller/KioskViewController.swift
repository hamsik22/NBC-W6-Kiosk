//
//  ViewController.swift
//  NBC-W6-Kiosk
//
//  Created by 황석현 on 11/25/24.
//  Updated by 김형석 on 11/27/24.

import UIKit
import SnapKit

class KioskViewController: UIViewController, Observer {
    var menu: Menu = Menu()
    var currentMenu: MenuCategory = .hot
    private var filteredMenuItems: [Product] = []
    
    private let bottomOrderView = BottomOrderView()
    private let orderList = OrderList()
    
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
        initializeMenu()
        
        setupUI()
        setupTableView()
        setupDelegates()
        menu.notifySelectedMenu(currentMenu)
    }
    
    // View가 그려지기 전에 json 데이터 디코팅 후 menu 모델에 저장
    private func initializeMenu() {
        if let data = fetchDataFromJSONFile() {
            menu.list = decode(from: data) ?? []
        }
        menu.addObserver(self)
    }
    
    private func setupDelegates() {
        orderList.delegate = self
        bottomOrderView.delegate = self
    }
    
    private func setupUI() {
        view.backgroundColor = .gray0
        [segmentedControl, tableView, orderList, bottomOrderView].forEach { view.addSubview($0) }
        
        segmentedControl.addTarget(
            self,
            action: #selector(segmentedControlValueChanged),
            for: .valueChanged
        )
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        segmentedControl.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(orderList.snp.top)
        }
        
        orderList.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomOrderView.snp.top)
            $0.height.equalTo(300)
        }
        
        bottomOrderView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(57)
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MenuItemCell.self, forCellReuseIdentifier: MenuItemCell.identifier)
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
        return filteredMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MenuItemCell.identifier,
            for: indexPath
        ) as? MenuItemCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: filteredMenuItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = filteredMenuItems[indexPath.row]
        orderList.addItem(selectedProduct)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
}

// MARK: - OrderList Delegate
extension KioskViewController: OrderListDelegate {
    func showMaxItemsAlert() {
        let alert = UIAlertController(
            title: "최대 수량 초과",
            message: "수량이 20개를 초과하였습니다.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - OrderButton Delegate
extension KioskViewController: BottomOrderViewDelegate {
    func cancelButtonDidTap() {
        let alert = UIAlertController(
            title: "주문 취소",
            message: "장바구니를 비우시겠습니까?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "확인", style: .destructive) { [weak self] _ in
            self?.orderList.clearCart()
        })
        
        present(alert, animated: true)
    }
    
    func orderButtonDidTap() {
        let alert = UIAlertController(
            title: "결제 확인",
            message: "결제를 진행하시겠습니까?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            self?.orderList.clearCart()
        })
        
        present(alert, animated: true)
    }
}

// MARK: - JSON Handling
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
