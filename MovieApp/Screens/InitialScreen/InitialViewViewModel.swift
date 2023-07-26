//
//  InitialViewViewModel.swift
//  MovieApp
//
//  Created by Liza on 27.04.2023.
//

import Foundation
import RxSwift

protocol InitialViewModelProtocol {
    func checkIfLogin()
}

class InitialViewViewModel: InitialViewModelProtocol, AuthenticationHandler {
    var apiService: ApiService?
    private let disposeBag = DisposeBag()
    let didCheckLoginStatus = PublishSubject<Bool>()
    init(apiService: ApiService?) {
        self.apiService = apiService
    }
    func checkIfLogin() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.checkLoginStatus(self.didCheckLoginStatus.asObserver().onNext(_:))
        }
    }
}
