//
//  LoginCoordinator.swift
//  MovieApp
//
//  Created by user222465 on 12/27/22.
//

import UIKit
import RxSwift

class LoginCoordinator: Coordinator {
    private let disposeBag = DisposeBag()
    let apiService: ApiService?
    weak var parentCoordinator: AppCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, apiService: ApiService?, parentCoorditor: AppCoordinator?) {
        self.navigationController = navigationController
        self.apiService = apiService
        self.parentCoordinator = parentCoorditor
    }
    
    func start() {
        let loginController = LoginViewController.instantiate()
        let viewModel = LoginViewViewModel(apiService: apiService)
        viewModel.didLogin.asObservable().subscribe(onNext: {[weak self] in
            self?.openMainTabController()}).disposed(by: disposeBag)
        loginController.viewModel = viewModel
        navigationController.pushViewController(loginController, animated: false)
    }
    
    func openMainTabController() {
        finish()
        parentCoordinator?.openMain()
    }
    
    func finish() {
        parentCoordinator?.removeChildCoordinator(self)
        print("finish")
    }
}
