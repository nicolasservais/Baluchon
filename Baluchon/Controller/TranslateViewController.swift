//
//  TranslateViewController.swift
//  Baluchon
//
//  Created by Nicolas SERVAIS on 13/09/2021.
//
import UIKit

final class TranslateViewController: UIViewController {
    enum Tapped {
        case up, down
    }
    private let heightBoxView: CGFloat = 140
    private let sizeButton: CGFloat = 50
    private var viewLocal: TranslateView
    private var viewTranslate: TranslateView
    private var buttonRefresh: RefreshButton
    private let translateService: TranslateService
    private let scrollView: UIScrollView
    private var spaceScroll: CGFloat = 1
    private let space: Space
    private var tapped: Tapped = .up
    init(space:Space) {
        self.space = space
        viewLocal = TranslateView()
        viewTranslate = TranslateView()
        buttonRefresh = RefreshButton(frame: CGRect(x: 0, y: 0, width: sizeButton, height: sizeButton), style: .arrowBlue)
        translateService = TranslateService.shared
        scrollView = UIScrollView()
        super.init(nibName: nil, bundle: nil)
        let icon = UITabBarItem(title: "Translate", image: UIImage(named: "Translate.png"), selectedImage: UIImage(named: "Translate.png"))
                self.tabBarItem = icon
        self.view.backgroundColor = .white
        self.view.backgroundColor = .systemMint
        scrollView.constraintToSafeArea()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        buttonRefresh.addTarget(self, action: #selector(tappedRefreshButton(_sender:)), for: .touchUpInside)
        view.backgroundColor = .white
        //redraw(size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
        view.addSubview(scrollView)
        scrollView.addSubview(viewLocal)
        scrollView.addSubview(viewTranslate)
        scrollView.addSubview(buttonRefresh)
        viewLocal.setData(language: "Français", text: "Tappez votre texte ici")
        viewTranslate.setData(language: "Anglais", text: "Type your text here")
        viewLocal.getTextField().delegate = self
        viewTranslate.getTextField().delegate = self
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        scrollView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        scrollView.contentSize.height = size.height+1
    }
    override func viewDidLayoutSubviews() {
        viewLocal.frame = CGRect(x: space.left, y: space.up, width: scrollView.frame.width-(space.left+space.right), height: heightBoxView)
        viewTranslate.frame = CGRect(x: space.left, y: space.up+space.min+heightBoxView, width: scrollView.frame.width-(space.left+space.right), height: heightBoxView)
        viewLocal.redraw(size: CGSize(width: scrollView.frame.width-(space.left+space.right), height: heightBoxView))
        viewTranslate.redraw(size: CGSize(width: scrollView.frame.width-(space.left+space.right), height: heightBoxView))
        buttonRefresh.frame = CGRect(x: (scrollView.frame.width/2)-sizeButton/2, y: space.up+heightBoxView-(sizeButton/2)+(space.min/2), width: sizeButton, height: sizeButton)
        scrollView.contentSize.height = scrollView.frame.height+1
    }
    @objc func tappedRefreshButton(_sender:RefreshButton) {
        self.buttonRefresh.changeButton(style: .roundedBlueRotate, animating: true)
        var text: String = ""
        var lang: String = ""
        switch tapped {
        case .up:
            text = viewLocal.getTextField().text!
            lang = "fr-en"
        case .down:
            text = viewTranslate.getTextField().text!
            lang = "en-fr"
        }
        translateService.getTranslate(text: text, lang: lang) { success, response in
            if success {
                switch self.tapped {
                case .up:
                    self.viewTranslate.getTextField().text = response
                case .down:
                    self.viewLocal.getTextField().text = response
                }
                self.buttonRefresh.changeButton(style: .valid, animating: true)
            } else {
                self.presentAlert()
                self.buttonRefresh.changeButton(style: .error, animating: true)
            }
        }
    }
    
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "The data download failed.", preferredStyle: .alert)
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

extension TranslateViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        buttonRefresh.changeButton(style: .arrowBlue, animating: true)
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
    func textFieldDidChangeSelection(_ textField: UITextField) {
        buttonRefresh.changeButton(style: .arrowBlue, animating: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        resetPositionScroll()
        return true
    }
}
