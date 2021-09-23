//
//  MeteoViewController.swift
//  Baluchon
//
//  Created by Nicolas SERVAIS on 13/09/2021.
//

import UIKit

class MeteoViewController: UIViewController {

    var stackView : UIStackView
    init() {
        stackView = UIStackView()
        super.init(nibName: nil, bundle: nil)
        let icon = UITabBarItem(title: "Meteo", image: UIImage(named: "Meteo32Light.png"), selectedImage: UIImage(named: "Meteo32Light.png"))
                self.tabBarItem = icon
        self.view.addSubview(stackView)
        self.view.backgroundColor = .darkGray
        start()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewWillAppear(_ animated: Bool) {
        stackView.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.size.width, height: view.frame.size.height-44)
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        stackView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height-44)
    }
    override func viewWillLayoutSubviews() {
    }
    func start() {

        let subDark: UIView = UIView()
        subDark.backgroundColor = .darkGray
        subDark.layer.cornerRadius = 8.0
        subDark.layer.borderWidth = 4
        subDark.layer.borderColor = UIColor.darkGray.cgColor
        stackView = UIStackView(arrangedSubviews: [getView(index: 0),getView(index: 1),subDark])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16.0
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    private func getView (index: Int) -> UIView {
        let myView: UIView = UIView()
        myView.backgroundColor = .white
        myView.layer.cornerRadius = 8.0
        myView.layer.borderWidth = 4
        myView.layer.borderColor = UIColor.darkGray.cgColor
                
        let buttonRefresh: RefreshButton = RefreshButton(frame: CGRect(x: 10, y: 60, width: 44, height: 44))

        let label: UILabel = UILabel()
        label.frame = CGRect(x: 8, y: 8, width: view.frame.width, height: 44)
        label.font = UIFont(name: "Arial", size: 30)
        label.textAlignment = .left
        label.textColor = .darkGray

        myView.addSubview(label)
        myView.addSubview(buttonRefresh)
        
        if index == 0 {
            label.text = "NewYork"
        } else if index == 1 {
            label.text = "Dompierre les ormes"
        }
        return myView
    }
}
