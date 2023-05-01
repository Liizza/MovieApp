//
//  TabBarViewViewModel.swift
//  MovieApp
//
//  Created by user222465 on 1/10/23.
//

import Foundation
import RxSwift
import RxCocoa

class MainTabBarViewViewModel: AuthenticationHandler {
    
    var apiService:ApiService?
    private let disposeBag = DisposeBag()
    let logOutButtonPressed = PublishSubject<Void>()
    let didLogOut = PublishSubject<Void>()
    
    init(apiService:ApiService?) {
        self.apiService = apiService
        bindLogOutButton()
    }
    private func bindLogOutButton() {
        self.logOutButtonPressed.asObservable().subscribe(onNext: {[weak self] in
          
            self?.logOut() { [weak self] result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(_):
                    self?.didLogOut.asObserver().onNext(())
                }
                
            }
        }).disposed(by: disposeBag)
        
    }
    
}
