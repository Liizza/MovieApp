//
//  GradientView.swift
//  MovieApp
//
//  Created by user222465 on 10/20/22.
//

import UIKit

class GradientView: UIView {

    private lazy var gradientLayer: CAGradientLayer = {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        var colors = [UIColor(red: 1/255, green: 25/255, blue: 147/255, alpha: 0.3), UIColor(red: 148/255, green: 17/255, blue: 0/255, alpha: 0.3)]
        gradient.colors = colors.map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }()
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
        gradientLayer.frame = bounds
    }

}
