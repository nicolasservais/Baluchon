//
//  MeteoViewController.swift
//  Baluchon
//
//  Created by Nicolas SERVAIS on 13/09/2021.
//

import UIKit

final class MeteoViewController: UIViewController {
    private let heightBoxView: CGFloat = 140
    private let sizeButton: CGFloat = 50
    private var viewLocal: MeteoView
    private var viewNY: MeteoView
    private var buttonRefresh: RefreshButton
    private let meteoService: MeteoService
    private let scrollView: UIScrollView
    private let space: Space
    init(space:Space) {
        self.space = space
        viewLocal = MeteoView()
        viewNY = MeteoView()
        buttonRefresh = RefreshButton(frame: CGRect(x: 0, y: 0, width: sizeButton, height: sizeButton), style: .roundedBlue)
        meteoService = MeteoService.shared
        scrollView = UIScrollView()
        super.init(nibName: nil, bundle: nil)
        let icon = UITabBarItem(title: "Meteo", image: UIImage(named: "Meteo32Light.png"), selectedImage: UIImage(named: "Meteo32Light.png"))
                self.tabBarItem = icon
        self.view.backgroundColor = .systemCyan
        scrollView.constraintToSafeArea()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        buttonRefresh.addTarget(self, action: #selector(tappedRefreshButton(_sender:)), for: .touchUpInside)
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(viewLocal)
        scrollView.addSubview(viewNY)
        scrollView.addSubview(buttonRefresh)
        viewLocal.setData(town: "Lyon", temperature: "21,6°C", weatherIcon: "10d")
        viewNY.setData(town: "New York", temperature: "23,2°C", weatherIcon: "11d")
    }
    override func viewWillAppear(_ animated: Bool) {
        buttonRefresh.changeButton(style: .roundedBlue, animating: true)
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        scrollView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        scrollView.contentSize.height = size.height+1
    }
    override func viewDidLayoutSubviews() {
        viewLocal.frame = CGRect(x: space.left, y: space.up, width: scrollView.frame.width-(space.left+space.right), height: heightBoxView)
        viewNY.frame = CGRect(x: space.left, y: space.up+space.min+heightBoxView, width: scrollView.frame.width-(space.left+space.right), height: heightBoxView)
        viewLocal.redraw(size: CGSize(width: scrollView.frame.width-(space.left+space.right), height: heightBoxView))
        viewNY.redraw(size: CGSize(width: scrollView.frame.width-(space.left+space.right), height: heightBoxView))
        buttonRefresh.frame = CGRect(x: (scrollView.frame.width/2)-sizeButton/2, y: space.up+heightBoxView-(sizeButton/2)+(space.min/2), width: sizeButton, height: sizeButton)
        scrollView.contentSize.height = scrollView.frame.height+1
    }
    
    @objc func tappedRefreshButton(_sender:RefreshButton) {
        self.buttonRefresh.changeButton(style: .roundedBlueRotate, animating: true)
        meteoService.getMeteo(place: "lyon") { (success, meteo) in
            if success, let meteo = meteo {
                self.viewLocal.setData(town: "Lyon", temperature: String(format: "%.1f°C", meteo.temperature), weatherIcon: meteo.icon)

                self.meteoService.getMeteo(place: "new york") { (success, meteo) in
                    if success, let meteo = meteo {
                        self.viewNY.setData(town: "New York", temperature: String(format: "%.1f°C", meteo.temperature), weatherIcon: meteo.icon)
                        self.buttonRefresh.changeButton(style: .valid, animating: true)
                    } else {
                        self.buttonRefresh.changeButton(style: .error, animating: true)
                        self.presentAlert()
                    }
                }

            } else {
                self.buttonRefresh.changeButton(style: .error, animating: true)
                self.presentAlert()
            }
        }
    }
    
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "The data download failed.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
