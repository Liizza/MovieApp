//
//  InitialCoordinator.swift
//  MovieApp
//
//  Created by Liza on 28.04.2023.
//

import UIKit
import RxSwift

class InitialCoordinator: Coordinator {
    let disposeBag = DisposeBag()
    let apiService: ApiService?
    var childCoordinators = [Coordinator]()
    var parentCoordinator: AppCoordinator?
    var navigationController: UINavigationController
    
    init(apiService: ApiService?, navigationController: UINavigationController, parentCoordinator: AppCoordinator?) {
        self.apiService = apiService
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        let vc = InitialViewController.instantiate()
        let viewModel = InitialViewViewModel(apiService: apiService)
        viewModel.didCheckLoginStatus.asObservable().subscribe(onNext: {[weak self] login in
            if login {
                self?.openMainController()
            } else {
                self?.openLoginController()
            }
        }).disposed(by: disposeBag)
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: false)
    }
    
    func openLoginController() {
        finish()
        parentCoordinator?.openLoginVC()
    }
    
    func openMainController() {
        finish()
        parentCoordinator?.openMain()
    }
    
    func finish() {
        self.parentCoordinator?.removeChildCoordinator(self)
    }
}
