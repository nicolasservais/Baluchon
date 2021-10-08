//
//  ChangeView.swift
//  Baluchon
//
//  Created by Nicolas SERVAIS on 05/10/2021.
//

import Foundation
import UIKit

final class ChangeView: UIView {

    private let labelCurrency: UILabel
    private let labelValue: UILabel
    private let textField: UITextField
    private let heightLabel: CGFloat = 44
    private let heightText: CGFloat = 80

    override init(frame: CGRect) {
        labelCurrency = UILabel()
        labelValue = UILabel()
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
        labelCurrency.frame = CGRect(x: 10, y: 6, width: self.frame.width-16, height: heightLabel)
        labelValue.frame = CGRect(x: self.frame.width-200, y: 6, width: 190, height: heightLabel)
        textField.frame = CGRect(x: 10, y: 50, width: self.frame.width-20, height: heightText)
    }
    
    private func viewDidLoad() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10.0
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.darkGray.cgColor
        labelCurrency.textColor = .darkGray
        labelCurrency.font = UIFont(name: "Arial", size: 36)
        labelCurrency.textAlignment = .left
        labelValue.textColor = .darkGray
        labelValue.font = UIFont(name: "Arial", size: 36)
        labelValue.textAlignment = .right
        textField.textColor = .darkGray
        textField.font = UIFont(name: "Arial", size: 24)
        textField.textAlignment = .center
        textField.backgroundColor = .white
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 8
        textField.keyboardType = .decimalPad
        self.addSubview(labelCurrency)
        self.addSubview(labelValue)
        self.addSubview(textField)
    }
    func setTargetDoneCancelToolBar(controller: ChangeViewController) {
        textField.addDoneCancelToolbar(onDone: (target: controller, action: #selector(controller.convertButtonTapped)), onCancel: (target: controller, action: #selector(controller.cancelButtonTapped)))
    }
    func setData(currency: String, value: String, text: String) {
        labelCurrency.text = currency
        labelValue.text = value
        textField.text = text
    }
    func getTextField() -> UITextField {
        return textField
    }
    func setCurrency(value: Double) {
        labelValue.text = String(format: "%.2f $", value)
    }
}
extension UITextField {
func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
    let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
    let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))

    let toolbar: UIToolbar = UIToolbar()
    toolbar.barStyle = .default
    toolbar.items = [
        UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
        UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
        UIBarButtonItem(title: "Convert", style: .done, target: onDone.target, action: onDone.action)
    ]
    toolbar.sizeToFit()

    self.inputAccessoryView = toolbar
}

// Default actions:
@objc func doneButtonTapped() { self.resignFirstResponder() }
@objc func cancelButtonTapped() { self.resignFirstResponder() }
    
}
