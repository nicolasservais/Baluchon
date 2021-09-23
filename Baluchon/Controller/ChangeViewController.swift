//
//  ChangeViewController.swift
//  Baluchon
//
//  Created by Nicolas SERVAIS on 13/09/2021.
//
import UIKit

class ChangeViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        let icon = UITabBarItem(title: "Change", image: UIImage(named: "Dollar.png"), selectedImage: UIImage(named: "Dollar.png"))
                self.tabBarItem = icon
        self.view.backgroundColor = .systemGreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

