//
//  AppCoordinator.swift
//  MovieApp
//
//  Created by user222465 on 12/27/22.
//

import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var apiService:ApiService?
    
    var window: UIWindow?
    
    init(window:UIWindow?){
        self.window = window
        self.apiService = AlamofireApiService()
    }
    
    func start() {
        openInitialVC()
    }
    func openInitialVC(){
        window?.rootViewController = nil
        let navController = UINavigationController()
        let child = InitialCoordinator(apiService: apiService, navigationController: navController, parentCoordinator: self)
        self.addChildCoordinator(child)
        child.start()
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
    func openLoginVC(){
        window?.rootViewController = nil
        let navController = UINavigationController()
        let child = LoginCoordinator(navigationController: navController, apiService: apiService, parentCoorditor: self)
        self.addChildCoordinator(child)
        child.start()
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    
    }
    func openMain(){
        window?.rootViewController = nil
        let mainNavigationController = UINavigationController()
        mainNavigationController.navigationBar.barStyle = .black
        let child = MainCoordinator(navigationController: mainNavigationController,apiService: apiService, parentCoordinator: self)
        self.addChildCoordinator(child)
        child.start()
        window?.rootViewController = mainNavigationController
        window?.makeKeyAndVisible()
        
    }
    
    func finish() {
        print("finish")
    }
    
    
    
    
}
