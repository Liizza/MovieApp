//
//  GradientBorderView.swift
//  MovieApp
//
//  Created by Liza on 03.04.2023.
//

import UIKit

class GradientBorderView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10
        gradientBorder(bouds: self.bounds, cornerRadius: 10)
        
    }
    func gradientBorder(bouds: CGRect, cornerRadius: CGFloat) {
        let gradient = CAGradientLayer()
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        gradient.frame =  path.bounds
        let colors = [UIColor(red: 255/255, green: 38/255, blue: 50/255, alpha: 1), UIColor(red: 14/255, green: 51/255, blue: 255/255, alpha: 1)]
        gradient.colors = colors.map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        let shape = CAShapeLayer()
        shape.lineWidth = 3
        shape.path = path.cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        if let layer = self.layer.sublayers?.last as? CAGradientLayer {
            layer.removeFromSuperlayer()
            
        }
        self.layer.addSublayer(gradient)
        return 
    }

    
}
