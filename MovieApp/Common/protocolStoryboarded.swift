//
//  protocolStoryboarded.swift
//  MovieApp
//
//  Created by user222465 on 12/6/22.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let name = NSStringFromClass(self)
        let className = name.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: className, bundle: nil)
        return storyboard.instantiateInitialViewController() as! Self
    }
}
