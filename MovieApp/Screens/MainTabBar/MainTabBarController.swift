//
//  TabBarController.swift
//  MovieApp
//
//  Created by user222465 on 10/22/22.
//

import UIKit
import RxSwift
import RxCocoa

class MainTabBarController: UITabBarController, Storyboarded {
    @IBOutlet weak var logOutButton: UIBarButtonItem!
    var viewModel: MainTabBarViewModelProtocol?
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    private func bind() {
        guard let viewModel else { return }
        logOutButton.rx.tap.asObservable().bind(to: viewModel.logOutButtonPressed.asObserver()).disposed(by: disposeBag)
    }
}
