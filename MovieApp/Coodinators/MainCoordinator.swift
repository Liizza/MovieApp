//
//  MainCoordinator.swift
//  MovieApp
//
//  Created by user222465 on 12/6/22.
//

import UIKit
import RxSwift

class MainCoordinator: Coordinator {
    
    private let disposeBag = DisposeBag()
    var childCoordinators: [Coordinator] = []
    private var apiService: ApiService?
    weak var parentCoordinator: AppCoordinator?
    var navigationController: UINavigationController
    
    init(navigationController:UINavigationController, apiService:ApiService?, parentCoordinator:AppCoordinator){
        self.navigationController = navigationController
        self.apiService = apiService
        self.parentCoordinator = parentCoordinator
        
    }
    
    func start() {
        let tabBarVC = MainTabBarController.instantiate()
        let viewModel = MainTabBarViewViewModel(apiService: apiService)
        viewModel.didLogOut.asObservable().subscribe(onNext: { [weak self] in self?.openLoginController()}).disposed(by: disposeBag)
        tabBarVC.viewModel = viewModel
        tabBarVC.viewControllers = [openGenresVC(),openSearchVC(),openFavoritesVC()]
        navigationController.pushViewController(tabBarVC, animated: false)
    }
    private func openGenresVC() -> UIViewController {
        let genresVC = GenresViewController.instantiate()
        let viewModel = GenresViewViewModel(apiService: apiService)
        viewModel.didOpenMovieController.asObservable().subscribe(onNext: {[weak self] movie in
            self?.openMovieDetailVC(movie: movie)
        }).disposed(by:disposeBag)
        genresVC.viewModel = viewModel
        return genresVC
    }
    private func openFavoritesVC() -> UIViewController {
        let favoritesVC = FavoritesViewController.instantiate()
        let viewModel = FavoritesViewViewModel(apiService:apiService)
        viewModel.didOpenMovieController.asObservable().subscribe(onNext: {[weak self] movie in
           
            self?.openMovieDetailVC(movie: movie)
        }).disposed(by: disposeBag)
        favoritesVC.viewModel = viewModel
        return favoritesVC
    }
    private func openSearchVC() -> UIViewController {
        let searchVC = SearchViewController.instantiate()
        let viewModel = SearchViewViewModel(apiService: apiService)
        viewModel.didOpenMovieController.asObservable().subscribe(onNext: {[weak self] movie in
            self?.openMovieDetailVC(movie: movie)
        }).disposed(by: disposeBag)
        searchVC.viewModel = viewModel
        return searchVC
        
    }
    
    private func openMovieDetailVC(movie:MovieProtocol?) {
        guard let movie else {
            return
        }
        let movieVC = MovieDetailsViewController.instantiate()
        movieVC.viewModel = MovieViewViewModel(movie: movie, apiService: apiService)
        navigationController.pushViewController(movieVC, animated: false)
    }
    func openLoginController() {
        finish()
        parentCoordinator?.openLoginVC()
        
    }
    func finish(){
        parentCoordinator?.removeChildCoordinator(self)
    }
    
    
    
}
