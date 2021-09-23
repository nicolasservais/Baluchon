//
//  TranslateViewController.swift
//  Baluchon
//
//  Created by Nicolas SERVAIS on 13/09/2021.
//
import UIKit

class TranslateViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        let icon = UITabBarItem(title: "Translate", image: UIImage(named: "Translate.png"), selectedImage: UIImage(named: "Translate.png"))
                self.tabBarItem = icon
        self.view.backgroundColor = .systemOrange

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

