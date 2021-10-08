//
//  MeteoView.swift
//  Baluchon
//
//  Created by Nicolas SERVAIS on 04/10/2021.
//

import Foundation
import UIKit

final class MeteoView: UIView {

    private let labelTown: UILabel
    private let labelTemperature: UILabel
    private let imageMeteo: UIImageView
    private let heightLabel: CGFloat = 44
    private let sizeLogo: CGFloat = 120
    
    override init(frame: CGRect) {
        labelTown = UILabel()
        labelTemperature = UILabel()
        imageMeteo = UIImageView()
        super.init(frame: frame)
        viewDidLoad()
        redraw(size: frame.size)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func redraw(size: CGSize) {
        self.frame.size = size
        labelTown.frame = CGRect(x: 10, y: 12, width: self.frame.width-16, height: heightLabel)
        labelTemperature.frame = CGRect(x: 16, y: 70, width: self.frame.width-16, height: heightLabel)
        imageMeteo.frame = CGRect(x: self.frame.width-sizeLogo-20, y: 10, width: sizeLogo, height: sizeLogo)
    }
    func viewDidLoad() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10.0
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.darkGray.cgColor
        labelTown.textColor = .darkGray
        labelTown.font = UIFont(name: "Arial", size: 36)
        labelTown.textAlignment = .left
        labelTemperature.textColor = .darkGray
        labelTemperature.font = UIFont(name: "Arial", size: 30)
        labelTemperature.textAlignment = .left
        imageMeteo.contentMode = .scaleAspectFit
        imageMeteo.clipsToBounds = true
        self.addSubview(labelTown)
        self.addSubview(labelTemperature)
        self.addSubview(imageMeteo)
        setData(town: "City", temperature: "20 °C", weatherIcon: "crossRed")
    }
    func setData(town: String, temperature: String, weatherIcon: String) {
        labelTown.text = town
        labelTemperature.text = temperature
        imageMeteo.image = UIImage(named: "\(weatherIcon).png")
    }
    
}
