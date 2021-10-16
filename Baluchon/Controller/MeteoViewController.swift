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
    private var viewOther: MeteoView
    private var buttonRefresh: RefreshButton
    private let meteoService: MeteoService
    private let scrollView: UIScrollView
    private let space: Space
    private let viewTranslucent: UIVisualEffectView
    private var placeLocal: String = "Lyon"
    private var placeOther: String = "New york"
    init(space:Space) {
        self.space = space
        viewLocal = MeteoView()
        viewOther = MeteoView()
        buttonRefresh = RefreshButton(frame: CGRect(x: 0, y: 0, width: sizeButton, height: sizeButton), style: .roundedBlue, name: "meteo")
        meteoService = MeteoService.shared
        scrollView = UIScrollView()
        viewTranslucent = UIVisualEffectView()
        super.init(nibName: nil, bundle: nil)
        let icon = UITabBarItem(title: "Meteo", image: UIImage(named: "Meteo32Light.png"), selectedImage: UIImage(named: "Meteo32Light.png"))
                self.tabBarItem = icon
    }
    required init?(coder: NSCoder) {
        // fatalError("init(coder:) has not been implemented")
        return nil
    }
    func setPlaceLocal(value: String) {
        placeLocal = value
    }
    func setPlaceOther(value: String) {
        placeOther = value
    }
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0.5, alpha: 0.7)
        scrollView.backgroundColor = .clear
        viewTranslucent.effect = UIBlurEffect(style: .light)
        buttonRefresh.addTarget(self, action: #selector(tappedRefreshButton(_sender:)), for: .touchUpInside)
        view.addSubview(viewTranslucent)
        view.addSubview(scrollView)
        scrollView.addSubview(viewLocal)
        scrollView.addSubview(viewOther)
        scrollView.addSubview(buttonRefresh)
        viewLocal.setData(town: placeLocal, temperature: "0,0°C", weatherIcon: "11d")
        viewOther.setData(town: placeOther, temperature: "0,0°C", weatherIcon: "11d")
        scrollView.constraintToSafeArea()
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
        viewOther.frame = CGRect(x: space.left, y: space.up+space.min+heightBoxView, width: scrollView.frame.width-(space.left+space.right), height: heightBoxView)
        viewLocal.redraw(size: CGSize(width: scrollView.frame.width-(space.left+space.right), height: heightBoxView))
        viewOther.redraw(size: CGSize(width: scrollView.frame.width-(space.left+space.right), height: heightBoxView))
        buttonRefresh.frame = CGRect(x: (scrollView.frame.width/2)-sizeButton/2, y: space.up+heightBoxView-(sizeButton/2)+(space.min/2), width: sizeButton, height: sizeButton)
        scrollView.contentSize.height = scrollView.frame.height+1
        viewTranslucent.frame = self.view.frame
    }
    
    @objc func tappedRefreshButton(_sender:RefreshButton) {
        var localOk: Bool = false
        var otherOk: Bool = false
        self.buttonRefresh.changeButton(style: .roundedBlueRotate, animating: true)
        meteoService.getMeteo(place: placeLocal) { (success, meteo) in
            if success, let meteo = meteo {
                self.viewLocal.setData(town: self.placeLocal, temperature: String(format: "%.1f°C", meteo.temperature), weatherIcon: meteo.icon)
                localOk = true
                self.meteoService.getMeteo(place: self.placeOther) { (success, meteo) in
                    if success, let meteo = meteo {
                        self.viewOther.setData(town: self.placeOther, temperature: String(format: "%.1f°C", meteo.temperature), weatherIcon: meteo.icon)
                        otherOk = true
                    }
                    if localOk && otherOk {
                        self.buttonRefresh.changeButton(style: .valid, animating: true)
                    } else {
                    //if !localOk || !otherOk {
                        self.buttonRefresh.changeButton(style: .error, animating: true)
                        self.presentAlert()
                    }
                }
            }
        }
    }
    
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "The data download failed.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
