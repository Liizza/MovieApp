//
//  protocolCoordinator.swift
//  MovieApp
//
//  Created by user222465 on 12/6/22.
//

import UIKit

protocol Coordinator: AnyObject {
    
    var childCoordinators: [Coordinator] {get set}
    
    func start()
    
    func finish()
    
    func addChildCoordinator(_ coordinator:Coordinator)
    func removeChildCoordinator(_ coordinator: Coordinator)
    func removeAllChildCoordinators()
    
    
}

extension Coordinator {
    
    func addChildCoordinator(_ coordinator: Coordinator) {
            childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ child:Coordinator) {
        for (index,coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
            }
        }
    }
    
    func removeAllChildCoordinators() {
            childCoordinators.removeAll()
    }
}
