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
    init() {
        space = Space()
        meteoViewController = MeteoViewController(space: space)
        translateViewController = TranslateViewController(space: space)
        changeViewController = ChangeViewController(space: space)
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
        self.setViewControllers([meteoViewController,translateViewController,changeViewController], animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.constraintToSafeArea()

        // Do any additional setup after loading the view.
        //self.view.translatesAutoresizingMaskIntoConstraints = false
        /*let guide = self.view.safeAreaLayoutGuide
        self.view.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        self.view.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        self.view.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        self.view.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        */
        //print("view : \(self.view.frame)")
        //self.view.constraintToSafeArea()
         //calculSpace()

    }
    //override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        //super.viewWillTransition(to: size, with: coordinator)
        //calculSpace()
        //print("view : \(self.view.frame)")

        //meteoViewController.redraw(size: size)
        //translateViewController.redraw(size: size)
        //changeViewController.redraw(size: size)
    //}
    func calculSpace() {
        //print("CALCUL SPACE")
        let bottom = UIApplication.shared.delegate?.window??.safeAreaInsets.bottom
        let top = UIApplication.shared.delegate?.window??.safeAreaInsets.top
        let left = UIApplication.shared.delegate?.window??.safeAreaInsets.left
        let right = UIApplication.shared.delegate?.window??.safeAreaInsets.right
        print("bottom \(String(describing: top)) \(String(describing: bottom)) \(String(describing: left)) \(String(describing: right))")
        /*space.up = (UIApplication.shared.delegate?.window??.safeAreaInsets.top)!
        space.down = (UIApplication.shared.delegate?.window??.safeAreaInsets.bottom)!
        space.left = 30//(UIApplication.shared.delegate?.window??.safeAreaInsets.left)!
        space.right = (UIApplication.shared.delegate?.window??.safeAreaInsets.right)!
        space.up = space.min
        space.down = space.min
        space.left = space.min
        space.right = space.min
        if let orientation = self.view.window?.windowScene?.interfaceOrientation {
            print("LLET OK")

            switch orientation {
            case .unknown:
                break
            case .portrait:
                space.up = space.max
            case .portraitUpsideDown:
                print("UpsideDown")
                space.down = space.max
            case .landscapeLeft:
                print("Left")
                space.left = space.max
            case .landscapeRight:
                space.right = space.max
            @unknown default:
                break
            }
        }
        */
    }


}

extension UIView {

    ///Constraints a view to its superview
    func constraintToSuperView() {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false

        topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
    }

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
