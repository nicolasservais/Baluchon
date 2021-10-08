//
//  ChangeViewController.swift
//  Baluchon
//
//  Created by Nicolas SERVAIS on 13/09/2021.
//
import UIKit

final class ChangeViewController: UIViewController {
    enum Tapped {
        case up, down
    }
    private let spaceAround: CGFloat = 12
    private let heightBoxView: CGFloat = 140
    private let spaceUp: CGFloat = 12
    private let spaceDown: CGFloat = 12
    private let spaceLeft: CGFloat = 12
    private let spaceRight: CGFloat = 12
    private let sizeButton: CGFloat = 50
    private var viewLocal: ChangeView
    private var viewOther: ChangeView
    private var buttonRefresh: RefreshButton
    private let changeService: ChangeService
    private let scrollView: UIScrollView
    private let space: Space
    private var tapped: Tapped = .up
    private var currency: Double = 1.09

    init(space:Space) {
        self.space = space
        viewLocal = ChangeView()
        viewOther = ChangeView()
        buttonRefresh = RefreshButton(frame: CGRect(x: 0, y: 0, width: sizeButton, height: sizeButton), style: .roundedBlue)
        changeService = ChangeService.shared
        scrollView = UIScrollView()
        super.init(nibName: nil, bundle: nil)
        let icon = UITabBarItem(title: "Change", image: UIImage(named: "Dollar.png"), selectedImage: UIImage(named: "Dollar.png"))
                self.tabBarItem = icon
        self.view.backgroundColor = .systemGreen
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
        scrollView.addSubview(viewOther)
        scrollView.addSubview(buttonRefresh)
        viewLocal.setData(currency: "Euro", value: "1 €", text: "Somme à convertir")
        viewOther.setData(currency: "Dollar", value: String(format: "%.2f $", currency), text: "Somme à convertir")
        viewLocal.getTextField().delegate = self
        viewOther.getTextField().delegate = self
        viewLocal.setTargetDoneCancelToolBar(controller: self)
        viewOther.setTargetDoneCancelToolBar(controller: self)
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
    }
    @objc func tappedRefreshButton(_sender:RefreshButton) {
        self.buttonRefresh.changeButton(style: .roundedBlueRotate, animating: true)
        
        changeService.getChange(currency: "USD") { success, result in
            if success {
                self.currency = result
                self.viewOther.setCurrency(value: result)
                self.buttonRefresh.changeButton(style: .valid, animating: true)
            } else {
                self.presentAlert(message: "The data download failed.")
                self.buttonRefresh.changeButton(style: .error, animating: true)
            }
        }
    }
    @objc func convertButtonTapped() {
        resetPositionScroll()
        switch tapped {
        case .up:
            if let euro: Double = Double(viewLocal.getTextField().text ?? "0.0") {
                viewOther.getTextField().text = String(format: "%.2f", euro*currency)
                viewLocal.getTextField().resignFirstResponder()
            } else {
                self.presentAlert(message: "The number Euro to convert is not correct")
            }
        case .down:
            if let dollar: Double = Double(viewOther.getTextField().text ?? "0.0") {
                viewLocal.getTextField().text = String(format: "%.2f", dollar/currency)
                viewOther.getTextField().resignFirstResponder()
            } else {
                self.presentAlert(message: "The number Dollar to convert is not correct")
            }
        }
    }
    @objc func cancelButtonTapped() {
        resetPositionScroll()
        switch tapped {
        case .up:
            viewLocal.getTextField().resignFirstResponder()
        case.down:
            viewOther.getTextField().resignFirstResponder()
        }
    }
    private func presentAlert(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    private func resetPositionScroll() {
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = 0
        } completion: {_ in
            self.scrollView.contentSize.height = self.scrollView.frame.height+1
        }
    }
    private func scrollDown(to: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = 154
        } completion: {_ in
            self.scrollView.contentSize.height = self.scrollView.frame.height+150
        }
    }
}
extension ChangeViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        viewLocal.getTextField().text = ""
        viewOther.getTextField().text = ""
        textField.selectAll(nil)
        tapped = .up
        if let originX = textField.superview?.frame.origin.y {
            if originX > 100 {
                tapped = .down
                if let orientation = self.view.window?.windowScene?.interfaceOrientation {
                    if orientation == .landscapeLeft || orientation == .landscapeRight {
                        scrollDown(to: originX)
                    }
                }
            }
        }
    }
}


