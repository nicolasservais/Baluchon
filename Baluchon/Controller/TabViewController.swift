//
//  ViewController.swift
//  Baluchon
//
//  Created by Nicolas SERVAIS on 13/09/2021.
//

import UIKit

struct Space {
    let min: CGFloat = 12
    let max: CGFloat = 30
    var up: CGFloat = 12
    var down: CGFloat = 12
    var left: CGFloat = 12
    var right: CGFloat = 12
}

final class TabViewController: UITabBarController {

    var meteoViewController: MeteoViewController
    var translateViewController: TranslateViewController
    var changeViewController: ChangeViewController
    var space: Space
    var image: UIImage = UIImage()
    
    init() {
        space = Space()
        meteoViewController = MeteoViewController(space: space)
        translateViewController = TranslateViewController(space: space)
        changeViewController = ChangeViewController(space: space)
        super.init(nibName: nil, bundle: nil)
        self.setViewControllers([meteoViewController,translateViewController,changeViewController], animated: false)
    }
    
    required init?(coder: NSCoder) {
        // fatalError("init(coder:) has not been implemented")
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = .red
        self.tabBar.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        self.tabBar.barStyle = .black
        image = UIImage(named: "rainbow")!
        self.view.layer.contents = image.cgImage
    }
}

extension UIView {
    ///Constraints a view to its superview safe area
    func constraintToSafeArea() {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        
        topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor).isActive = true
        leftAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leftAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor).isActive = true
        rightAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.rightAnchor).isActive = true
    }
}
