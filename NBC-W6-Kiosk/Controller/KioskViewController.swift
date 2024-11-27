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
    
    private var filteredMenuItems: [DefaultProduct] = []
    
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
        
        shoppingBasket = DefaultShoppingBasket()
        shoppingBasket.addObserver(self)
        
        setupUI()
        setupTableView()
        menu.notifySelectedMenu(.coffee)
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
        
        menu.notifySelectedMenu(selectedCategory)
    }
    
    func fetchMenu(_ filteredList: [DefaultProduct]) {
        filteredMenuItems = filteredList
        tableView.reloadData()
    }
    
    func fetchShoppingBasket(_ list: [DefaultProduct]) {
        // MARK: menuTableViewCell을 탭하면 shoppingBasket 모델에서 해당 상품을 등록하고 리스트를 전달인자로 넘겨줍니다.
        // TODO: 장바구니에 보여질 상품 데이터들을 list 전달인자를 기반으로 구현하면 됩니다.
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

#if DEBUG

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
