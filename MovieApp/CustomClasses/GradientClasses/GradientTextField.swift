//
//  GradientTextField.swift
//  MovieApp
//
//  Created by user222465 on 10/20/22.
//

import UIKit

class GradientTextField: UITextField {

    private lazy var gradientBorderLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius)
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
        self.layer.addSublayer(gradient)
        return gradient
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
        setPlaceholderColor(color: .white)
        self.layer.cornerRadius = 10
        gradientBorderLayer.frame = bounds
    }
    
    func setPlaceholderColor(color:UIColor) {
        guard let placeholder = self.placeholder else {
            return
        }
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.6)])
        
    }
    
    func addImageView(imageName:String) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.height, height:self.bounds.height))
        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: self.bounds.height - 10, height: self.bounds.height - 10))
        let image = UIImage(imageLiteralResourceName: imageName)
        imageView.contentMode = .center
        imageView.image = image;
        view.addSubview(imageView)
        self.leftView = view
        self.leftView?.alpha = 1
        self.self.leftViewMode = .always
    }
}
