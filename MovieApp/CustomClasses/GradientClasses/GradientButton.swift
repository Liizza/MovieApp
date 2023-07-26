//
//  GradientButton.swift
//  MovieApp
//
//  Created by user222465 on 10/19/22.
//

import UIKit

class GradientButton: UIButton {
    private lazy var gradientLayer: CAGradientLayer = {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        var colors = [UIColor(red: 255/255, green: 38/255, blue: 50/255, alpha: 1), UIColor(red: 14/255, green: 51/255, blue: 255/255, alpha: 1)]
        gradient.cornerRadius = self.layer.cornerRadius
        gradient.colors = colors.map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }()
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10
        gradientLayer.frame = bounds
    }
}
