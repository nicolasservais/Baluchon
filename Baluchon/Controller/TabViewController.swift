//
//  ViewController.swift
//  Baluchon
//
//  Created by Nicolas SERVAIS on 13/09/2021.
//

import UIKit

class TabViewController: UITabBarController {

    var meteoViewController: MeteoViewController
    var translateViewController: TranslateViewController
    var changeViewController: ChangeViewController
    
    init() {
        meteoViewController = MeteoViewController()
        translateViewController = TranslateViewController()
        changeViewController = ChangeViewController()
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
        self.setViewControllers([meteoViewController,translateViewController,changeViewController], animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

