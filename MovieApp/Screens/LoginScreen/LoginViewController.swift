//
//  LoginViewController.swift
//  MovieApp
//
//  Created by user222465 on 10/4/22.
//

import UIKit
import RxSwift
import RxCocoa
class LoginViewController: BaseViewController {
    
    var viewModel: LoginViewModelProtocol?
    
    @IBOutlet weak var passwordTextField: GradientTextField!
    @IBOutlet weak var userNameTextField: GradientTextField!
    @IBOutlet weak var loginButton: GradientButton!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var stayLoggedInSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindElements()
        bindTextFields()
        configureElements()
    }
    
    private func configureElements() {
        notificationView.isHidden = true
        userNameTextField.addImageView(imageName: "user")
        passwordTextField.addImageView(imageName: "padlock")
    }
    
    private func bindTextFields() {
        guard let viewModel else { return }
        userNameTextField.rx.text.orEmpty.asObservable().bind(to: viewModel.userName).disposed(by: disposeBag)
        passwordTextField.rx.text.orEmpty.bind(to: viewModel.password).disposed(by: disposeBag)
        userNameTextField.rx.controlEvent(.editingDidEndOnExit).asDriver().drive(onNext: { [weak self] in
            self?.passwordTextField.becomeFirstResponder()
        }).disposed(by: disposeBag)
        passwordTextField.rx.controlEvent(.editingDidEndOnExit).asDriver().drive(onNext: { [weak self] in
            self?.passwordTextField.resignFirstResponder()
        }).disposed(by: disposeBag)
    }
    
    private func bindElements() {
        guard let viewModel else { return }
        stayLoggedInSwitch.setOn(viewModel.switchIsOn, animated: true)
        stayLoggedInSwitch.rx.value.asObservable().bind(to: viewModel.ifStayLoginSwitchPressed).disposed(by: disposeBag)
        loginButton.rx.tap
            .asObservable()
            .bind(to: viewModel.loginButtonPressed.asObserver())
            .disposed(by: disposeBag)
        viewModel.notificationLabelText.drive(onNext: {[weak self] text in
            self?.notificationView.isHidden = false
            self?.notificationLabel.text = text
        }).disposed(by: disposeBag)
    }
}
