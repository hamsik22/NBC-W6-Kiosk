//
//  ViewController.swift
//  NBC-W6-Kiosk
//
//  Created by 황석현 on 11/25/24.
//

import UIKit
import SwiftUI

class KioskViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
