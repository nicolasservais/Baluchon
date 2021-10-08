//
//  TranslateView.swift
//  Baluchon
//
//  Created by Nicolas SERVAIS on 04/10/2021.
//

import Foundation
import UIKit

final class TranslateView: UIView {

    private let labelLanguage: UILabel
    private let textField: UITextField
    private let heightLabel: CGFloat = 44
    private let heightText: CGFloat = 80

    override init(frame: CGRect) {
        labelLanguage = UILabel()
        textField = UITextField()
        super.init(frame: frame)
        viewDidLoad()
        redraw(size: frame.size)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func redraw(size: CGSize) {
        self.frame.size = size
        labelLanguage.frame = CGRect(x: 10, y: 6, width: self.frame.width-16, height: heightLabel)
        textField.frame = CGRect(x: 10, y: 50, width: self.frame.width-20, height: heightText)
    }
    
    private func viewDidLoad() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10.0
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.darkGray.cgColor
        labelLanguage.textColor = .darkGray
        labelLanguage.font = UIFont(name: "Arial", size: 36)
        labelLanguage.textAlignment = .left
        textField.textColor = .darkGray
        textField.font = UIFont(name: "Arial", size: 24)
        textField.textAlignment = .center
        textField.backgroundColor = .white
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 8
        self.addSubview(labelLanguage)
        self.addSubview(textField)
        //textField.delegate = self
    }
    
    func setData(language: String, text: String) {
        labelLanguage.text = language
        textField.text = text
    }
    func getTextField() -> UITextField {
        return textField
    }
    
}

