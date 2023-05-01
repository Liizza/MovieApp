//
//  LoginViewViewModel.swift
//  MovieApp
//
//  Created by user222465 on 11/10/22.
//

import Foundation
import KeychainSwift
import RxSwift
import RxCocoa

class LoginViewViewModel: AuthenticationHandler {
    
    var apiService: ApiService?
    
    private let disposeBag = DisposeBag()
    
    let userName = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    
    let loginButtonPressed = PublishSubject<Void>()
    
    let ifStayLoginSwitchPressed = PublishSubject<Bool>()
    var switchIsOn = UserDefaults.standard.bool(forKey:"StayLoginIn")
    
    let didLogin = PublishSubject<Void>()
    
    private let _notificationLabelText = BehaviorRelay<String>(value: "")

    var notificationLabelText: Driver<String>{
        return _notificationLabelText.asDriver()
    }
    
    init(apiService:ApiService?) {
        self.apiService = apiService
        bindLogInButton()
        bindSwitch()
    }
    
    private func bindSwitch() {
        ifStayLoginSwitchPressed.asObservable().subscribe(onNext: { isOn in
            UserDefaults.standard.set(isOn, forKey: "StayLoginIn")
        }).disposed(by: disposeBag)
    }
    private func bindLogInButton() {
        self.loginButtonPressed.asObservable().subscribe(onNext: {[weak self] in
            self?.login()
        }).disposed(by: disposeBag)
    }
   
    private func login(){
        guard !self.userName.value.isEmpty, !password.value.isEmpty else{
            _notificationLabelText.accept("Enter username and password")
            return
        }
        
        logInAndSavePassword(userName: self.userName.value, password: self.password.value, savePasword: UserDefaults.standard.bool(forKey:"StayLoginIn")) { [weak self] result in
            switch result {
            case .success(_:):
                self?.didLogin.asObserver().onNext(())
            case .failure(let error):
                self?._notificationLabelText.accept(error.rawValue)
            }
            
        }
    }
}
